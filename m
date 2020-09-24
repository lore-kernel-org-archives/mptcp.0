Content-Type: multipart/mixed; boundary="===============7745149281642482918=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 7/8] mptcp: move page frag allocation in
 mptcp_sendmsg()
Date: Thu, 24 Sep 2020 16:24:46 +0200
Message-ID: <323382b5b4ef71becdf9bdee4c7e45822c88f505.camel@redhat.com>
In-Reply-To: e36a743b0bfe7fc2b0fb7799d087c29021df634c.1600955407.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6023

--===============7745149281642482918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-24 at 15:59 +0200, Paolo Abeni wrote:
> @@ -1855,18 +1823,17 @@ static void mptcp_worker(struct work_struct
> *work)
>  =

>  	lock_sock(ssk);
>  =

> -	orig_len =3D dfrag->data_len;
> -	orig_offset =3D dfrag->offset;
> -	orig_write_seq =3D dfrag->data_seq;
> -	while (dfrag->data_len > 0) {
> -		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &info);
> +	/* limit retransmission to the bytes already sent on some
> subflows */
> +	info.sent =3D 0;
> +	info.limit =3D dfrag->already_sent;
> +	while (info.sent < dfrag->already_sent) {
> +		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
>  		if (ret < 0)
>  			break;

I noted only shortly after posting... here should be 'ret <=3D 0' or we
risk an infinite loop.

/P

--===============7745149281642482918==--
