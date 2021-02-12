Content-Type: multipart/mixed; boundary="===============7439234009460357502=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/8] mptcp: move subflow close loop after sk
 close check
Date: Fri, 12 Feb 2021 15:59:57 -0800
Message-ID: <20210213000001.379332-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210213000001.379332-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7787

--===============7439234009460357502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

In case mptcp socket is already dead the entire mptcp socket
will be freed. We can avoid the close check in this case.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 267c5521692d..1b8be2bf6b43 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2246,9 +2246,6 @@ static void mptcp_worker(struct work_struct *work)
 =

 	mptcp_check_fastclose(msk);
 =

-	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		__mptcp_close_subflow(msk);
-
 	if (msk->pm.status)
 		mptcp_pm_nl_work(msk);
 =

@@ -2270,6 +2267,9 @@ static void mptcp_worker(struct work_struct *work)
 		goto unlock;
 	}
 =

+	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
+		__mptcp_close_subflow(msk);
+
 	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		goto unlock;
 =

-- =

2.30.1

--===============7439234009460357502==--
