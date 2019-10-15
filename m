Content-Type: multipart/mixed; boundary="===============7099670653118767650=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Tue, 15 Oct 2019 22:39:55 +0200
Message-ID: <009d27af4eb0b39293a215013596e2c445a0be7b.camel@redhat.com>
In-Reply-To: cover.1571152990.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2156

--===============7099670653118767650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 17:44 +0200, Paolo Abeni wrote:
> I think this 3 patches should be squashed into
> "mptcp: Implement MPTCP receive path", but the resulting one will be like=
ly
> too huge; possibly splitting the resulting code in 2 different patches wo=
uld
> be nicer. Additionally "mptcp: Implement MPTCP receive path" has some chu=
nks
> that should be likely moved to some other patches (e.g. ULP RCU fixes).
> =

> What if - after the eventuall accept - I publish the resulting code of th=
e =

> above squashing somewhere?

Since I'm an incurable optimist, I went ahead and pushed the rebase
here:

https://github.com/pabeni/mptcp/tree/mptcp-proposal-recvmsg_rebase_7

Squashed:
"mptcp: flush duplicate data at data_ready() time"
and
"mptcp: move some helper into the header file"
  into "mptcp: Implement MPTCP receive path"
    (and rewrote the commit message)

"mptcp: harmonize locking on all socket operations."
  partially in =

    "mptcp: Associate MPTCP context with TCP socket"
  and partially in
    "mptcp: Create SUBFLOW socket for incoming connections"

Moved the RCU bits from "mptcp: Implement MPTCP receive path"
into:
  "mptcp: Associate MPTCP context with TCP socket"

Moved the options/ack_seq bits from "mptcp: Implement MPTCP receive
path" into:
  "mptcp: Write MPTCP DSS headers to outgoing data packets"

Rebased "mptcp: recvmsg() can drain data from multiple subflows" on top
of "mptcp: Implement MPTCP receive path"

Removed a few intentation issue.

I checked for build issue only on the modified patches.

The overall diff from current export branch plus the pending patches is
reported below.

---
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6b11a908cca7..3ebf3ece6d85 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -201,7 +201,7 @@ struct mptcp_subflow_context {
 	u64	idsn;
 	u64	map_seq;
 	u32	token;
-	u32     rel_write_seq;
+	u32	rel_write_seq;
 	u32	map_subflow_seq;
 	u32	ssn_offset;
 	u32	map_data_len;
@@ -209,9 +209,9 @@ struct mptcp_subflow_context {
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
 		request_version : 4,
-		mp_capable : 1,     /* remote is MPTCP capable */
-		mp_join : 1,        /* remote is JOINing */
-		fourth_ack : 1,     /* send initial DSS */
+		mp_capable : 1,	    /* remote is MPTCP capable */
+		mp_join : 1,	    /* remote is JOINing */
+		fourth_ack : 1,	    /* send initial DSS */
 		conn_finished : 1,
 		map_valid : 1,
 		backup : 1,
@@ -225,9 +225,8 @@ struct mptcp_subflow_context {
 	u8	local_id;
 	u8	remote_id;
 =

-	struct  socket *tcp_sock;  /* underlying tcp_sock */
-	struct  sock *conn;        /* parent mptcp_sock */
-
+	struct	socket *tcp_sock;   /* underlying tcp_sock */
+	struct	sock *conn;	    /* parent mptcp_sock */
 	void	(*tcp_sk_data_ready)(struct sock *sk);
 	struct	rcu_head rcu;
 };

--===============7099670653118767650==--
