Content-Type: multipart/mixed; boundary="===============8354526182214425036=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 3/3] mptcp: move subflow close loop after sk
 close check
Date: Tue, 02 Feb 2021 18:47:54 +0100
Message-ID: <20210202174754.6861-4-fw@strlen.de>
In-Reply-To: 20210202174754.6861-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7597

--===============8354526182214425036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case mptcp socket is already dead the entire mptcp socket
will be freed. We can avoid the close check in this case.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 24eb42a60844..9472bb265e32 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2244,9 +2244,6 @@ static void mptcp_worker(struct work_struct *work)
 =

 	mptcp_check_fastclose(msk);
 =

-	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		__mptcp_close_subflow(msk);
-
 	if (msk->pm.status)
 		mptcp_pm_nl_work(msk);
 =

@@ -2268,6 +2265,9 @@ static void mptcp_worker(struct work_struct *work)
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

2.26.2

--===============8354526182214425036==--
