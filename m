Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423049;
	b=ERg1VMPRxLQL4Mjv2KtYR2Q0NwPbtwDMxUG4xnV4rjdcH/58g8Z7YSl2wrHRdz8VNcUR
	 9FXSqJZq5SM11+wIWqMEfGose72FCFxixv9AKYpyTvZ2cDwvPtx5ju9GiDXvYHRWnv51L
	 rtSJKH8/Pqy/yv+STi9SW5Og5QvdY3BHCLnIt3IfjMw2+avMfrf7NffHKH3ZO+rhz//wl
	 WgqR0CQPGvgX4qvyo6RQsmieIjyc4zYmMKawjESZCVVILyENRl3qQ1oKPjUynLruLNNL0
	 gQDbDutIHHhNsTcV81FsVq96AEzpU3PV5EGu47tR8W2wC8T8rHQlzqYEugK78TBRWeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mLZS0o3kdU1hv6VH06LquZXnsRC4MaDNUztC+4lCzbQ=;
	b=K2Tol804i2FkPRw10vOfgh2w1xtGOdcG1vws+/JwYSPoCYhhuLyudSCrK2GTyls04rBm
	 ubPugKeGNupeF8/jZaCfM+Wwb90HhoqdyxhAFQdggCLg4CP3WX9u4hQj+QtugNqJKJn6V
	 JoETLYK3znq8bMPix7nbRmDDBdlGeTS5J+hgYSXqlgckwxVvGBg6aawTVUxOdzXP22TVQ
	 adAhZTqajizN6hz+KwcpRXqdgi2C4M0eKRMMv7bOxk5EnjUsNptCY8r5J+tCl6DKjPsnE
	 Psed02PxI68wJFOWxCHTy5/cpa6g3NthWiJMj+ztsC6oldWPqnVwrKw69r0PGDyOM9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAvZN2YJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A047606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAvZN2YJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570671F000CA;
	Mon, 23 Nov 2026 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423048;
	bh=mLZS0o3kdU1hv6VH06LquZXnsRC4MaDNUztC+4lCzbQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DAvZN2YJmI8bLqMdVwTvx3j77rd1S0u70pTB/mHayXzekQDrxCoFAANzd/3hCJ2Y7
	 jXPryQ+bWQ//vgTmFeonb+1pSf8GvjTkMk+0S5LN62Ms1+ICN5hbax3dy17DSr2i6j
	 koJGISoOfxdbkMdi/0CM23AC8OyI9+3rHAl9xM2HF7z6PU0ovQsLq3I5lTqCOJE6Ob
	 SZ5tDkGiUgtwe7KRCKfT/jfNBIP7yZFOupYuQ7YEWfwIhqZiJvyKPV89Uv/DKT1TL9
	 5xGK20iThKXIbIx2nXNZUlDnOresoyP1zWmATqW2EyGS2bvLuNM/5ZmxIXsxwvf5va
	 gVLEeV63Hj9Xg==
Message-ID: <sashiko-outbox-228908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 6/7] selftests: mptcp: connect: add
 zerocopy io mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <9d10433a1bc453357a5994906ff3029f0e1f76a1.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
 <9d10433a1bc453357a5994906ff3029f0e1f76a1.1795421388.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:37:27 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] selftests: mptcp: premature buffer free in do_sendmsg_zc()
  after first cmsg
- [Medium] selftests: mptcp: undersized msg_control buffer in
  drain_errqueue_zc()
- [Medium] selftests: mptcp: ignored zc errors and wait on 0 sent in
  do_sendmsg_zc()
- [Medium] selftests: mptcp: unconditional set_sndbuf() and 0-size MPTFO
  in copyfd_io_zc()
- [Low] selftests: mptcp: int overflow in size * 2 and unlooped read in
  do_sendmsg_zc()
--

commit 0f0d4fe1bd34bb0fc128a15413afd453172d8483
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: connect: add zerocopy io mode

This commit adds a 'zerocopy' I/O mode to the mptcp_connect selftest that
transmits data using sendmsg() with MSG_ZEROCOPY and drains completion
notifications from the socket error queue.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 8c788977e5947..08fd505132030 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1014,6 +1016,180 @@ static int copyfd_io_splice(int infd, int peerfd,=
 int outfd, unsigned int size,
>  	return err;
>  }
> =20
> +static bool process_cmsg_zc(struct msghdr *errmsg)
> +{
> +	struct sock_extended_err *serr;
> +	struct cmsghdr *cm;
> +
> +	for (cm =3D CMSG_FIRSTHDR(errmsg); cm; cm =3D CMSG_NXTHDR(errmsg, cm)) {
> +		if (cm->cmsg_level !=3D SOL_IP && cm->cmsg_level !=3D SOL_IPV6)
> +			continue;
> +		if (cm->cmsg_type !=3D IP_RECVERR &&
> +		    cm->cmsg_type !=3D IPV6_RECVERR)
> +			continue;
> +
> +		serr =3D (struct sock_extended_err *)CMSG_DATA(cm);
> +		if (serr->ee_origin =3D=3D SO_EE_ORIGIN_ZEROCOPY)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool drain_errqueue_zc(int peerfd)
> +{
> +	size_t ctl_len =3D CMSG_SPACE(sizeof(struct sock_extended_err));
> +	struct msghdr errmsg =3D {};
> +	bool found =3D false;
> +	char *ctl;
> +
> +	ctl =3D malloc(ctl_len);

[Severity: Medium]
Is ctl_len large enough for the control messages queued on the error
queue?

ip_recv_error() and ipv6_recv_error() append an offender sockaddr_in or
sockaddr_in6 after struct sock_extended_err, so a buffer of
CMSG_SPACE(sizeof(struct sock_extended_err)) triggers MSG_CTRUNC on every
recvmsg(MSG_ERRQUEUE) call.  They also call sock_recv_timestamp() before
queuing IP_RECVERR or IPV6_RECVERR, so running with -c TIMESTAMPNS fills
the entire 32-byte control buffer with the timestamp cmsg and drops the
zero-copy completion cmsg, leaving wait_for_completions_zc() to stall
until timeout.

> +	if (!ctl) {
> +		perror("malloc ctl");
> +		return false;
> +	}
> +
> +	errmsg.msg_control =3D ctl;
> +
> +	while (!found) {
> +		errmsg.msg_controllen =3D ctl_len;
> +		if (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE) < 0)
> +			break;
> +
> +		found =3D process_cmsg_zc(&errmsg);
> +	}
> +
> +	free(ctl);
> +	return found;
> +}
> +
> +static void wait_for_completions_zc(int peerfd)
> +{
> +	struct pollfd pfd =3D { .fd =3D peerfd, .events =3D POLLERR };
> +	struct timespec start, now;
> +	int timeout_ms =3D 5000;
> +
> +	if (cfg_time > 0)
> +		timeout_ms =3D cfg_time;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +	for (;;) {
> +		long elapsed_ms, remaining_ms;
> +
> +		if (drain_errqueue_zc(peerfd))
> +			break;

[Severity: Medium]
Does wait_for_completions_zc() return as soon as the first
SO_EE_ORIGIN_ZEROCOPY notification arrives rather than waiting for all
issued sendmsg(MSG_ZEROCOPY) calls to complete?

Each sendmsg() in do_sendmsg_zc() allocates a new notification ID in
mptcp_sendmsg() via msg_zerocopy_realloc() (and in TCP whenever the 512 KB
byte limit is exceeded), so transfers larger than SO_SNDBUF (clamped to
sysctl_wmem_max) produce multiple completion IDs.  Stopping after the
first cmsg without checking the completed [serr->ee_info, serr->ee_data]
range against the number of sendmsg() calls causes do_sendmsg_zc() to call
free(buf) while later zero-copy segments are still pinned and in flight,
and leaves unread notifications on sk_error_queue.

> +
> +		clock_gettime(CLOCK_MONOTONIC, &now);
> +		elapsed_ms =3D (now.tv_sec - start.tv_sec) * 1000L +
> +			     (now.tv_nsec - start.tv_nsec) / 1000000L;
> +		if (elapsed_ms >=3D timeout_ms)
> +			break;
> +
> +		remaining_ms =3D timeout_ms - elapsed_ms;
> +		if (remaining_ms > 200)
> +			remaining_ms =3D 200;
> +		if (poll(&pfd, 1, remaining_ms) < 0)
> +			break;
> +	}
> +}
> +
> +static int do_sendmsg_zc(int infd, int peerfd, size_t size,
> +			 struct wstate *winfo)
> +{
> +	struct iovec iov =3D {};
> +	struct msghdr msg =3D {
> +		.msg_iov =3D &iov,
> +		.msg_iovlen =3D 1,
> +	};
> +	size_t sent =3D 0;
> +	ssize_t ret;
> +	void *buf;
> +	int err;
> +
> +	err =3D spool_buf(peerfd, winfo);
> +	if (err)
> +		return err;
> +
> +	buf =3D malloc(size);
> +	if (!buf) {
> +		perror("malloc");
> +		return 1;
> +	}
> +
> +	if (read(infd, buf, size) !=3D (ssize_t)size) {
> +		perror("read input");
> +		err =3D 1;
> +		goto out;
> +	}

[Severity: Low]
Can a single unlooped read(infd, buf, size) fail on partial reads or EINTR
for large input files?  In addition, set_sndbuf(peerfd, size * 2) in
copyfd_io_zc() multiplies unsigned int size by 2, which overflows signed
int in setsockopt(SO_SNDBUF) when size exceeds INT_MAX / 2.

> +
> +	while (sent < size) {
> +		iov.iov_base =3D buf + sent;
> +		iov.iov_len =3D size - sent;
> +
> +		ret =3D sendmsg(peerfd, &msg, MSG_ZEROCOPY);
> +		if (ret <=3D 0) {
> +			if (ret < 0) {
> +				perror("sendmsg MSG_ZEROCOPY");
> +				err =3D 1;
> +			}
> +			break;
> +		}
> +		sent +=3D ret;
> +	}
> +	if (sent !=3D size)
> +		fprintf(stderr, "sendmsg short: %zu/%zu bytes queued\n",
> +			sent, size);
> +
> +	if (size > 0)
> +		wait_for_completions_zc(peerfd);

[Severity: Medium]
Should do_sendmsg_zc() check sent > 0 instead of size > 0 before calling
wait_for_completions_zc(), and propagate completion and short-send
failures?

If the first sendmsg() fails (for example with ENOBUFS when RLIMIT_MEMLOCK
is exceeded), sent is 0 and no completion will ever be queued, yet
wait_for_completions_zc() still blocks for the full 5000 ms timeout.
Furthermore, wait_for_completions_zc() returns void (ignoring poll_timeout
from -t) so completion timeouts, poll() errors, and malloc() failures in
drain_errqueue_zc() return 0 from do_sendmsg_zc(); process_cmsg_zc() does
not check serr->ee_errno or SO_EE_CODE_ZEROCOPY_COPIED; and a 0 return
from sendmsg() with sent < size logs "sendmsg short" without setting
err =3D 1.

> +
> +out:
> +	free(buf);
> +	return err;
> +}
> +
> +static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int si=
ze,
> +			bool *in_closed_after_out, struct wstate *winfo)
> +{
> +	socklen_t len;
> +	int on =3D 1;
> +	int err;
> +
> +	set_sndbuf(peerfd, size * 2);

[ ... ]

> @@ -1054,6 +1230,17 @@ static int copyfd_io(int infd, int peerfd, int out=
fd, bool close_peerfd, struct
>  				       &in_closed_after_out, winfo);
>  		break;
> =20
> +	case CFG_MODE_ZEROCOPY:
> +		file_size =3D get_infd_size(infd);
> +		if (file_size < 0)
> +			return file_size;
> +		if (cfg_sockopt_types.mptfo && winfo->total_len &&
> +		    file_size >=3D winfo->total_len)
> +			file_size -=3D winfo->total_len;
> +		ret =3D copyfd_io_zc(infd, peerfd, outfd, file_size,
> +				   &in_closed_after_out, winfo);
> +		break;

[Severity: Medium]
What happens when -o MPTFO is used with an input file of 8192 bytes or
smaller, or when -S is passed to configure SO_SNDBUF?

When MPTFO is enabled and the input file fits in winfo->buf (8192 bytes),
sock_connect_mptcp() reads the entire file into winfo->buf, so
file_size -=3D winfo->total_len reduces size to 0; copyfd_io_zc() then calls
set_sndbuf(peerfd, 0) and do_sendmsg_zc() calls malloc(0), which fails the
test on libcs where malloc(0) returns NULL.  In addition, calling
set_sndbuf(peerfd, size * 2) unconditionally in copyfd_io_zc() overrides
any -S cfg_sndbuf option and sets SOCK_SNDBUF_LOCK, disabling TCP and
MPTCP send buffer autotuning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795421388.gi=
t.tanggeliang@kylinos.cn?part=3D6
