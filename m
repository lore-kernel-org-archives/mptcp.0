Content-Type: multipart/mixed; boundary="===============2853981946268983030=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 01/13] tcp: factor out tcp_build_frag()
Date: Fri, 13 Nov 2020 11:38:13 +0100
Message-ID: <3a20827d0a695b646579c94b7bbf2a185a3226dc.camel@redhat.com>
In-Reply-To: 20201112151254.14e3b059@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6712

--===============2853981946268983030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-12 at 15:12 -0800, Jakub Kicinski wrote:
> On Thu, 12 Nov 2020 15:08:31 -0800 Jakub Kicinski wrote:
> > On Thu, 12 Nov 2020 18:45:21 +0100 Paolo Abeni wrote:
> > > +		skb =3D sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
> > > +				tcp_rtx_and_write_queues_empty(sk));  =

> > =

> > no good reason to misalign this AFAICT
> =

> Maybe not worth respining just for this, I thought there are build
> warnings but seems it's mostly sparse getting confused.

Thanks for looking into this!

The misalign comes from the orginal TCP code, which I tried to keep as
unmodfied as possible to simplify the review. Anyhow I had to drop an
indentation level, so there are really no excuse for me.

I'll address this in the next iteration, if other changes will be
needed

> Is there a chance someone could look into adding annotations to socket
> locking?

Annotating lock_sock_fast()/unlock_sock_fast() as they would
unconditionally acquire/release the socket spinlock removes the warning
related to fast lock - at least for me;).

Hopefully that does not interact with lockdep, but perhpas is a bit too
extreme/rusty?

Something alike the following:

---
diff --git a/include/net/sock.h b/include/net/sock.h
index fbd2ba2f48c0..26db18024b74 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1591,7 +1591,8 @@ void release_sock(struct sock *sk);
 				SINGLE_DEPTH_NESTING)
 #define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
 =

-bool lock_sock_fast(struct sock *sk);
+bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
+
 /**
  * unlock_sock_fast - complement of lock_sock_fast
  * @sk: socket
@@ -1601,11 +1602,14 @@ bool lock_sock_fast(struct sock *sk);
  * If slow mode is on, we call regular release_sock()
  */
 static inline void unlock_sock_fast(struct sock *sk, bool slow)
+		   __releases(&sk->sk_lock.slock)
 {
-	if (slow)
+	if (slow) {
 		release_sock(sk);
-	else
+		__release(&sk->sk_lock.slock);
+	} else {
 		spin_unlock_bh(&sk->sk_lock.slock);
+	}
 }
 =

 /* Used by processes to "lock" a socket state, so that
diff --git a/net/core/sock.c b/net/core/sock.c
index 727ea1cc633c..9badbe7bb4e4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3078,7 +3078,7 @@ EXPORT_SYMBOL(release_sock);
  *
  *   sk_lock.slock unlocked, owned =3D 1, BH enabled
  */
-bool lock_sock_fast(struct sock *sk)
+bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
 {
 	might_sleep();
 	spin_lock_bh(&sk->sk_lock.slock);
@@ -3096,6 +3096,7 @@ bool lock_sock_fast(struct sock *sk)
 	 * The sk_lock has mutex_lock() semantics here:
 	 */
 	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
+	__acquire(&sk->sk_lock.slock);
 	local_bh_enable();
 	return true;
 }



--===============2853981946268983030==--
