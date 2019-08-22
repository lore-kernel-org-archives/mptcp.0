Content-Type: multipart/mixed; boundary="===============3767498463354050258=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v2 8/8] mptcp: implement and use MPTCP-level
 retransmission
Date: Thu, 22 Aug 2019 20:39:23 +0200
Message-ID: <b6d423b5f08e03d080dc7f02a8d5415dd8f2864d.camel@redhat.com>
In-Reply-To: b98c2da44e68a642bc4500297e48ea636cd9fd54.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1678

--===============3767498463354050258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 15:47 +0200, Paolo Abeni wrote: =

> +static void mptcp_retransmit(struct work_struct *work)
> +{
> +	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, rtx_wo=
rk);
> +	struct sock *ssk, *sk =3D &msk->sk.icsk_inet.sk;
> +	int orig_len, orig_offset, orig_write_seq;
        ^^^^                       ^^^^^^^^^^^^^^

For the records, the above is broken, 'orig_write_seq' must be an u64.

It looks like there is still some other issue, self-tests still fail,
sometime.

Regards,

Paolo


--===============3767498463354050258==--
