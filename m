Content-Type: multipart/mixed; boundary="===============2647472963778101710=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Wed, 16 Oct 2019 10:58:17 +0200
Message-ID: <b5f1f0fcc2063a30c6ff9fe73d16a81643ac24ac.camel@redhat.com>
In-Reply-To: 38674e3a-37b1-9b08-b86b-9c8e35c5fd14@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2168

--===============2647472963778101710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-16 at 10:37 +0200, Matthieu Baerts wrote:
> On 16/10/2019 10:22, Paolo Abeni wrote:
> > Yes, I'm cooking patch && rebase right now. I hopefully will send soon
> > v2 of the patches with a reference to the rebase branch in the cover
> > letter.
> =

> If you only adds the line mentioned by Mat, I am fine if you update your =

> branch directly, no need to send new patches that we will not use =

> directly

The new rebase branch is:

https://github.com/pabeni/mptcp/tree/mptcp-proposal-recvmsg_rebase_8

It still includes the additional cleanups mentioned yday:

* Squashed:
"mptcp: flush duplicate data at data_ready() time"
and
"mptcp: move some helper into the header file"
  into "mptcp: Implement MPTCP receive path"
    (and rewrote the commit message)

* Squashed:
"mptcp: harmonize locking on all socket operations."
  partially in =

    "mptcp: Associate MPTCP context with TCP socket"
  and partially in
    "mptcp: Create SUBFLOW socket for incoming connections"

* Moved the RCU bits from "mptcp: Implement MPTCP receive path"
into:
  "mptcp: Associate MPTCP context with TCP socket"

* Moved the options/ack_seq bits from "mptcp: Implement MPTCP receive
path" into:
  "mptcp: Write MPTCP DSS headers to outgoing data packets"

* Rebased "mptcp: recvmsg() can drain data from multiple subflows" on
top of "mptcp: Implement MPTCP receive path"

* Removed a few intentation/whitespace issue.

It's based on top of net-next commit 77ffe33363c0 ("hv_sock: use
HV_HYP_PAGE_SIZE for Hyper-V communication")

I checked for build issue only on the modified patches.

> , a diff is fine :-)

I'm sorry, I'm unsure what I should diff !?!

Anyhow, this is the diff vs. yday rebase branch/patches:

---
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b2fd57341889..b13548a0df1a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -402,7 +402,7 @@ static enum mapping_status
get_mapping_status(struct sock *ssk)
                 * real data_fin support
                 */
                pr_debug("DATA_FIN with no payload");
-               return MAPPING_OK;
+               return MAPPING_DATA_FIN;
        }

        if (!mpext->dsn64) {
---

And this is the diff vs the current export branch with the current
recevmsg refactor changes applied - only whitespaces to tabs
modifications:
---
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 871711940419..3ebf3ece6d85 100644
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
---

Please let me know if something different is preferred and/or needed,
thanks!

Paolo

--===============2647472963778101710==--
