"""migration

Revision ID: 6949e69234af
Revises: 
Create Date: 2024-07-16 09:39:46.517552

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '6949e69234af'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('web')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('web',
    sa.Column('id', mysql.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('ShopName', mysql.VARCHAR(length=255), nullable=True),
    sa.Column('ShopRating', mysql.FLOAT(), nullable=True),
    sa.Column('Category_catchtable', mysql.VARCHAR(length=255), nullable=True),
    sa.Column('Location_catchtable', mysql.VARCHAR(length=255), nullable=True),
    sa.Column('LunchDinner', mysql.VARCHAR(length=50), nullable=True),
    sa.Column('Description', mysql.TEXT(), nullable=True),
    sa.Column('Reviews', mysql.INTEGER(), autoincrement=False, nullable=True),
    sa.Column('Address', mysql.TEXT(), nullable=True),
    sa.Column('Location', mysql.VARCHAR(length=255), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb4_0900_ai_ci',
    mysql_default_charset='utf8mb4',
    mysql_engine='InnoDB'
    )
    # ### end Alembic commands ###
