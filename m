Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDA402B83
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837959; cv=none; b=sSpK1f5YEIfvWarMAeNJnNuf6/UpFixf98m7zG9PBstzFhskJXjeOGWdCE1+LkAU/ID3Kh3yagnkga2+Z/YcPFucX7giK7iD3/eJ8f+eovI5/eA+VPiv34ngm50ldUTUm5I1jvdrPLogV35dtORcvDXDYC7dH/0E4HZ9DLmP7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837959; c=relaxed/simple;
	bh=XUdjPe0T/nhSS9txnAgfRSRRq1zEwq5PC4oWbgkwMCA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=jdMsY1ZIUsMP5wN6FYtQHbIy98s+ESruZLbBnN69ZXVPAUSB80Xc7HmfZpEaYFVoCQW9dYCFbWc6Vo4jN+WMFxTc657C9gpUW7U4opM07rJnJ+RML6Eb4Cc2VrVhIFV25C/OTH0c4COhG9vT9hm5jKI2BifvG85UVAb2j6awzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pREgtzRY; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pREgtzRY"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778837955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05maUbDumwKvh0iUNgd2+ielX1y37+G6wn19ag54u5c=;
	b=pREgtzRYFdidW6FYIb00Xw2RKXfacqmbOpdTLLJa8W1fUZQtTJOOdGZe7KtkD68C5qtDEa
	V5UMGgGBPVCtj0DUO8JNZoOe9/jvALNM4VjO19zxFf3YEtNpiWjRfKQO927mFZda/w2Si6
	IpW3EdG7Al7nRdWeC3S+5CFFQj3WcVo=
Date: Fri, 15 May 2026 09:39:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <62bce132417a3c98a6ad6aea821dba9de1002916@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v4 1/2] mptcp: use sockopt_lock(release)_sock
 in sockopt
To: "Paolo Abeni" <pabeni@redhat.com>, "MPTCP Linux" <mptcp@lists.linux.dev>
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <2678c535-2b51-4a04-803e-14a2e3ac348b@redhat.com>
References: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
 <20260509-sockopt_lock-v4-1-33f3a1c4d7a0@kylinos.cn>
 <cb257c5c1af85f1512a175730e832c7b8cc7ba14@linux.dev>
 <2678c535-2b51-4a04-803e-14a2e3ac348b@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 15, 2026 at 5:06 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@r=
edhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20Hi,
>=20
>=20On 5/15/26 3:27 AM, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> May 9, 2026 at 2:44 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.=
yan@linux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:
> >=20
>=20> >=20
>=20> > From: Gang Yan <yangang@kylinos.cn>
> > >=20
>=20> >  TCP and the core socket layer all use sockopt_lock_sock()
> > >  sockopt_release_sock() in their setsockopt and getsockopt handlers=
. It
> > >  is a BPF-aware wrapper that skips lock acquisition when invoked fr=
om a
> > >  BPF program, where the socket lock is already held.
> > >=20
>=20> >  Using lock_sock_fast() on subflows requires extra care: the fast=
 path
> > >  holds the socket spinlock with BH disabled, creating an atomic con=
text
> > >  where sleeping is not allowed. Switching to lock_sock() avoids the
> > >  risk of accidentally introducing sleeping operations inside the
> > >  lock_sock_fast() critical section.
> > >=20
>=20> >  Fixes: 24426654ed3a ("bpf: net: Avoid sk_setsockopt() taking sk =
lock when called from bpf")
> > >  Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > >  ---
> > >  net/mptcp/sockopt.c | 97 ++++++++++++++++++++++++++---------------=
------------
> > >  1 file changed, 48 insertions(+), 49 deletions(-)
> > >=20
>=20> >  diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > >  index 1cf608e7357b..57ffde0d0b87 100644
> > >  --- a/net/mptcp/sockopt.c
> > >  +++ b/net/mptcp/sockopt.c
> > >  @@ -72,12 +72,12 @@ static void mptcp_sol_socket_sync_intval(struc=
t mptcp_sock *msk, int optname, in
> > >  struct mptcp_subflow_context *subflow;
> > >  struct sock *sk =3D (struct sock *)msk;
> > >=20=20
>=20> >  - lock_sock(sk);
> > >  + sockopt_lock_sock(sk);
> > >  sockopt_seq_inc(msk);
> > >=20=20
>=20> >  mptcp_for_each_subflow(msk, subflow) {
> > >  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > >  - bool slow =3D lock_sock_fast(ssk);
> > >=20
>=20>=20=20
>=20>  Hi, Maintainers:
> >=20=20
>=20>  Thanks for the review of sashiko. Let me address these two points.
> >=20=20
>=20>  First, I think this patch does not introduce issues for existing M=
PTCP code.
> >  Currently there is no scenario where a BPF program invokes the MPTCP
> >  setsockopt/getsockopt handler =E2=80=94 BPF helpers (bpf_setsockopt)=
 bypass the
> >  protocol-specific handler via __bpf_setsockopt(), and the cgroup BPF=
 sockopt
> >  filter clears the BPF context before calling ops->setsockopt(). So
> >  has_current_bpf_ctx() is always false when the MPTCP handler execute=
s. The
> >  commit's primary purpose, as stated in the commit message, is to rep=
lace
> >  lock_sock_fast() with lock_sock() to avoid sleeping within the
> >  lock_sock_fast() critical section.
> >=20=20
>=20>=20=20
>=20>  The subflow locking concern is valid for future BPF support.
> >=20=20
>=20>  That said, the observation about the subflow locking gap is a vali=
d design
> >  concern. As sashiko pointed out, when the MPTCP setsockopt handler i=
s
> >  eventually called from BPF context, the MPTCP meta socket (msk) is a=
lready
> >  locked externally, but the subflow sockets (ssk) are not. The intern=
al
> >  delegation via sk_setsockopt(ssk, ...) or tcp_setsockopt(ssk, ...) c=
alls
> >  sockopt_lock_sock(ssk) which skips the lock due to the per-thread
> >  has_current_bpf_ctx() flag, leaving ssk unprotected.
> >=20=20
>=20>  However, solving this is not straightforward. In BPF context we do=
n't have a
> >  good way to call lock_sock() on the subflow =E2=80=94 as sashiko not=
ed in first point,
> >  lock_sock() unconditionally calls might_sleep(), and will cause 'sle=
eping in
> >  atomic context' problems in BPF context. So properly locking the sub=
flow in
> >  BPF context remains an open question that needs to be addressed when=
 MPTCP
> >  BPF setsockopt support is actually introduced.
> >=20
Hi=20Paolo,

Thanks for your reply.

> I'm sorry for the late feedback. I think such concern is actually quite
> relevant. Note that replacing
>=20
>=20 bool slow =3D lock_sock_fast(ssk);
>=20
>=20with:
>=20
>=20 lock_sock(ssk);
>=20
>=20does not change much WRT the sleeping issue.

I'm not questioning your point, but just to confirm =E2=80=94 when you me=
ntioned the
"sleeping issue", are you referring to the BPF context?

In fact, this patch addresses an issue that occurs in non-BPF scenarios l=
ike
sashiko said in [1]:

https://sashiko.dev/#/patchset/20260420093343.16443-1-gang.yan@linux.dev

>=20
>=20I *think* the only viable path in the short term is making the sockop=
t
> requiring subflow-level lock fail when called by BPF.
>
> In a possible long term alternative could be delegating the
> subflow-level changes to a workqueue, but that really looks invasive an=
d
> I would really like to avoid such option.

I agree that the short-term approach sounds reasonable for now. We could
either implement the sockopt failure for BPF calls that require subflow-l=
evel
locking, or simply add a comment to mark this limitation clearly.

As far as I can see, MPTCP currently doesn=E2=80=99t have any real-world =
use cases
for setting sockopt via BPF anyway. The workqueue approach also seems too=
 complex
and invasive for the current stage, so I=E2=80=99d prefer to avoid it for=
 now.

WDYT=EF=BC=9F

Cherrs,
Gang

>=20
>=20/P
>
