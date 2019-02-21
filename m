Content-Type: multipart/mixed; boundary="===============2582261321356929580=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC mptcp 0/4] mptcp: kselftest program and a few
 bugs
Date: Thu, 21 Feb 2019 08:45:09 -0800
Message-ID: <alpine.OSX.2.21.1902210840070.3866@anpatel-mobl2.amr.corp.intel.com>
In-Reply-To: 20190207142711.3475-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1011

--===============2582261321356929580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Feb 2019, Florian Westphal wrote:

> Hi.
>
> First patch adds a small mptcp test program, nothing fancy,
> just transmits stdin via mptcp connection and back out again.
>
> Uncovers a few issues, the one unfixed is that
> read(mptcpfd, buf, buflen)
>
> can return cause data to be discarded.
> In that case, read() returns a value larger than "buflen".
> Did not investigate further so far.

Florian -

Thanks for finding that read bug. This appears to fix it (I will update =

the patch set to include this):

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bed3be1c380b..46603af09b25 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -319,6 +319,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
  	while (copied < len) {
  		enum mapping_status status;
  		size_t discard_len =3D 0;
+		u32 map_remaining;
  		int bytes_read;
  		u64 ack_seq;
  		u64 old_ack;
@@ -411,7 +412,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
  		}

  		/* Read mapped data */
-		desc.count =3D ssn - subflow->map_subflow_seq + subflow->map_dll;
+		map_remaining =3D (ssn - subflow->map_subflow_seq +
+				 subflow->map_dll);
+		desc.count =3D min_t(size_t, len - copied, map_remaining);
  		arg.msg =3D msg;
  		bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
  		if (bytes_read < 0)

--
Mat Martineau
Intel

--===============2582261321356929580==--
