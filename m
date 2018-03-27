Content-Type: multipart/mixed; boundary="===============4150968578003558248=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] How function pointers will be replaced
Date: Tue, 27 Mar 2018 15:57:45 -0700
Message-ID: <c460b76e-b00b-3adf-8305-34f43e615720@oracle.com>
X-Status: 
X-Keywords:                  
X-UID: 432

--===============4150968578003558248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am in the process of replacing function pointers with a macro that =

calls the appropriate function based on the socket. Mat, suggested that =

I share what it looks like. So here it is.

The current code in the patch:

/* Send _single_ skb sitting at the send head. This function requires
 =C2=A0* true push pending frames to setup probe timer etc.
 =C2=A0*/
void tcp_push_one(struct sock *sk, unsigned int mss_now)
{
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb =3D tcp_sen=
d_head(sk);

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!skb || skb->len < mss_n=
ow);

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_sk(sk)->op_ops->write_xmit(=
sk, mss_now, TCP_NAGLE_PUSH, 1,
sk->sk_allocation);
}

After my fix to not use function pointers it will look like

/* Send _single_ skb sitting at the send head. This function requires
 =C2=A0* true push pending frames to setup probe timer etc.
 =C2=A0*/
void tcp_push_one(struct sock *sk, unsigned int mss_now)
{
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb =3D tcp_sen=
d_head(sk);

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!skb || skb->len < mss_n=
ow);

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CALL_ONE(tcp_write_xmit, sk, ms=
s_now, TCP_NAGLE_PUSH, 1,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sk->sk_allocation);
}

/* Macro to call appropriate function depending upon the socket type.
 =C2=A0* First two arguments are required to be the name of the function =

called and socket
 =C2=A0* pointer respectively. Any other arguments are optional as required=
 by
 =C2=A0* the called function.
 =C2=A0*/
#define CALL_ONE(fn, __sk, ...) \
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (likely (!tcp_sk(__sk)->tcp_alt=
) ? \
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (fn)(__sk, ##__VA_ARGS__) : (mp=
##fn)(__sk, ##__VA_ARGS__))

I am not happy about this as function pointers kept the code cleaner. If =

anyone has better ideas or see any issues please speak up so I can make =

the change now than later.

Thanks,

Shoaib


--===============4150968578003558248==--
