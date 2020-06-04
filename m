Content-Type: multipart/mixed; boundary="===============3511659516529846309=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] inet_connection_sock: clear inet_num out of
 destroy helper
Date: Thu, 04 Jun 2020 18:55:45 +0200
Message-ID: <cc2adbd7dcc17c44e2858e550302906760b38a0b.1591289527.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4586

--===============3511659516529846309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Clearing the 'inet_num' field is necessary and safe if and
only if the socket is not bound. The MPTCP protocol calls
the destroy helper on bound sockets, as tcp_v{4,6}_syn_recv_sock
completed successfully.

Move the clearing of such field out of the common code, otherwise
the MPTCP MP_JOIN error path will find the wrong 'inet_num' value
on socket disposal, __inet_put_port() will acquire the wrong lock
and bind_node removal could race with other modifiers possibly
corrupting the bind hash table.

Reported-and-tested-by: Christoph Paasch <cpaasch(a)apple.com>
Fixes: 729cd6436f35 ("mptcp: cope better with MP_JOIN failure")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/inet_connection_sock.h | 1 -
 net/ipv4/inet_connection_sock.c    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connecti=
on_sock.h
index 2f1f8c3efb26..e5b388f5fa20 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -292,7 +292,6 @@ static inline void inet_csk_prepare_for_destroy_sock(st=
ruct sock *sk)
 	/* The below has to be done to allow calling inet_csk_destroy_sock */
 	sock_set_flag(sk, SOCK_DEAD);
 	percpu_counter_inc(sk->sk_prot->orphan_count);
-	inet_sk(sk)->inet_num =3D 0;
 }
 =

 void inet_csk_destroy_sock(struct sock *sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index f40b1b72f979..afaf582a5aa9 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -902,6 +902,7 @@ void inet_csk_prepare_forced_close(struct sock *sk)
 	bh_unlock_sock(sk);
 	sock_put(sk);
 	inet_csk_prepare_for_destroy_sock(sk);
+	inet_sk(sk)->inet_num =3D 0;
 }
 EXPORT_SYMBOL(inet_csk_prepare_forced_close);
 =

-- =

2.21.3

--===============3511659516529846309==--
