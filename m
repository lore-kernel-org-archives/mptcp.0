Content-Type: multipart/mixed; boundary="===============1449795282120818794=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 1/8] mptcp: create the
 listening socket for new port
Date: Tue, 15 Dec 2020 13:49:20 +0800
Message-ID: <CA+WQbwshsW0FcjdCnPRvU+aubDZtwRMsJMtHqgx4oLRki-4v6g@mail.gmail.com>
In-Reply-To: 81bbbc826edf123d47abfa74dbaf9e0674689cf2.1607823272.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7170

--===============1449795282120818794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=8813=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=889:52=E5=86=99=E9=81=93=EF=BC=
=9A
>
> This patch created a listening socket when an address with a port-number
> is added by PM netlink. Then binded the new port to the socket, and
> listened for the connection.

Please update the commit message:

---

This patch created a listening socket when an address with a port-number
is added by PM netlink. Then binded the new port to the socket, and
listened for the connection.

When the address is removed or the addresses are flushed by PM netlink,
release the listening socket.

---

-Geliang
--===============1449795282120818794==--
