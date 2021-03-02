Content-Type: multipart/mixed; boundary="===============4359179125139643243=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/3] mptcp: check the removing
 initial subflow
Date: Tue, 02 Mar 2021 16:12:48 +0800
Message-ID: <e496b266e0b5c7e559cced0802c7112583e53b29.1614672171.git.geliangtang@gmail.com>
In-Reply-To: 7c2fd9748228b631cb40a45b2752d85f0b5f84d7.1614672171.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7977

--===============4359179125139643243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the removing address id is 0, the initial subflow needs to be removed.
Since the initial subflow's both local_id and remote_id are all zeros,
this patch checks them to make sure it's now removing the right subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index eaac9824f444..439c9ee57566 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -629,6 +629,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptc=
p_sock *msk,
 			if (rm_list.ids[i] !=3D id)
 				continue;
 =

+			if (!rm_list.ids[i]) {
+				if (subflow->local_id || subflow->remote_id)
+					continue;
+			}
+
 			pr_debug(" -> %s rm_list_ids[%d]=3D%u local_id=3D%u remote_id=3D%u",
 				 type =3D=3D RM_ADDR ? "address" : "subflow", i, rm_list.ids[i],
 				 subflow->local_id, subflow->remote_id);
-- =

2.29.2

--===============4359179125139643243==--
