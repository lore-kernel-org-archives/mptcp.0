Content-Type: multipart/mixed; boundary="===============5779227681228218603=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] stray code chunks in current export branch
Date: Thu, 31 Oct 2019 17:55:47 +0100
Message-ID: <259f95245ea4bb1edcf6f2da46611d63839c74c3.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2381

--===============5779227681228218603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

as per last mtg discussion, patch "mptcp: Write MPTCP DSS headers to
outgoing data packets", includes:

@@ -208,6 +303,14 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 =

                mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
                msk->subflow =3D NULL;
+
+               mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
+               msk->write_seq =3D subflow->idsn + 1;
+               ack_seq++;
+               msk->ack_seq =3D ack_seq;
+               msk->remote_key =3D subflow->remote_key;
+               msk->ack_seq++;

'remote_key' is set a few lines above, and the 2nd ack_seq increment is
wrong, we just incr it once.

The 2 bottom lines are deleted by "mptcp: Implement MPTCP receive
path". We should avoid inserting them at all. @Matt, can you do that
with git surgery, or do you prefer a patch?

Thanks,

Paolo

--===============5779227681228218603==--
