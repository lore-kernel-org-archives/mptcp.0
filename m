Received: from mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55313B1008
	for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207788; cv=none; b=gRpdBOxhOHVqm5XlqUaic8YU0ABiOdRq+GGNaFAFYDbzmLfZ+qy3WahQ8ZX6ZgeMm8LJme3cyvDnRI2s+EBg1rUeCGhQV1C96IxtrzxOcohFXTjjOXxSMwb0X7nuOBupq40foo2GyHjnocP6ae2NpQuEsYzazkSkKso/NFSxiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207788; c=relaxed/simple;
	bh=zl4m3TH5c31mEN7uxesWzJFt4/YXRA+Gmugnd1W+xTc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=EttwcMqbphUAh4plkc1ZX/06w8ioZksfpBNUj03vy433DKOs1szGE72LRdP3UTZZNXYnIe91LI9kJJhUvZWxFDT4hLmo+PacGX49P5r/HseQEWn6+1S6RGO92oczSGdhJ8hw7S24hPkNHYyOgNyY9uqGQCs4+r7iosQuY5+YLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i1W1/Gtc; arc=none smtp.client-ip=95.215.58.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i1W1/Gtc"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=zl4m3TH5c31mEN7uxesWzJFt4/YXRA+Gmugnd1W+xTc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787207780; v=1; x=1787812580;
 b=i1W1/Gtcz1I7g4RhILkdfPsIF1sUe9Lfeal8zrdlCt1cMIMRn0UjT+LF+zra+IuLu++kynjR
 jjZU2S0EveC5FVu0i3UY/u4jyj+WG0hQ4V23S7jTxAdynsIVLa74DnrEi4DrjKqSMWni9v/kuBx
 FP9Cj13kC2b+2laaczYBHIy0=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id ea843c083ba60cad;
	Thu, 20 Aug 2026 06:36:20 +0000
X-Mizu-Trace-ID: ea843c083ba60cad
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 06:36:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <7b85c6e1e4e270bd368fb7dc6d24279c1c20c3b2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v3 5/5] Squash to "mptcp: pm: init and release
 mptcp_pm_ops"
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260819131205.3A0201F000E9@smtp.kernel.org>
References: <20260819125629.49823-1-gang.yan@linux.dev>
 <20260819125629.49823-6-gang.yan@linux.dev>
 <20260819131205.3A0201F000E9@smtp.kernel.org>

August 19, 2026 at 9:12 PM, sashiko-bot@kernel.org mailto:sashiko-bot@ker=
nel.org  wrote:

> [Severity: Critical]
> Since this series introduces mptcp_pm_ops lifetime handling and module
> references, is there a race condition with concurrent MP_JOIN requests?
>=20
>=20When an incoming MP_JOIN request is processed in softirq context,
> subflow_token_join_request() gets the socket via mptcp_token_get_sock()=
,
> which doesn't hold lock_sock() or RCU. It then calls:
>=20
>=20net/mptcp/pm.c:mptcp_pm_get_local_id() {
>  ...
>  return msk->pm.ops->get_local_id(msk, &skc_local);
> }
>=20
>=20Concurrently, if a local user closes the socket and triggers
> mptcp_disconnect(msk), it calls mptcp_pm_ops_release() which clears the=
 ops
> and drops the module reference:
>=20
>=20net/mptcp/pm.c:mptcp_pm_ops_release() {
>  ...
>  msk->pm.ops =3D NULL;
>  ...
>  bpf_module_put(pm_ops, pm_ops->owner);
> }
>=20
>=20Could this lead to a NULL pointer dereference or executing freed modu=
le code
> if subflow_token_join_request() executes concurrently with a socket
> disconnect?
>=20

Hi=20Matt, Geliang

@Matt, Could you help me to trigger the CI?

And I think it is a pre-existing bug:=20

When=20it calls msk->pm.ops->get_local_id(msk, &skc_local) between
'mptcp_distroy_common' (which calls mptcp_pm_ops_release) and
'mptcp_pm_data_reset'. The pm.ops will be NULL and cause a NULL deref, ri=
ght?

If I'm right, I think we can using rcu to solve this based on this series=
, like:

  - Add a helper to get pm.ops, and then call the get_local_id/get_priori=
ty under rcu_lock:
'''
+static struct mptcp_pm_ops *mptcp_pm_deref(struct mptcp_sock *msk)
+{
+       struct mptcp_pm_ops *pm_ops;
+
+       pm_ops =3D rcu_dereference(msk->pm.ops);
+       return pm_ops ? pm_ops : &mptcp_pm_kernel;
+}
+

bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
=20
=20       mptcp_local_address((struct sock_common *)skc, &skc_local);
=20
-=20      return msk->pm.ops->get_priority(msk, &skc_local);
+       return mptcp_pm_deref(msk)->get_priority(msk, &skc_local);
 }
=20
So=20does the mptcp_pm_get_local_id like this.

static struct mptcp_sock *subflow_token_join_request(struct request_sock =
*req)
                return NULL;
        }
=20
+=20      rcu_read_lock();
        local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)req=
);
        if (local_id < 0) {
                SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
+               rcu_read_unlock();
                sock_put((struct sock *)msk);
                return NULL;
        }
        subflow_req->local_id =3D local_id;
        subflow_req->request_bkup =3D mptcp_pm_is_backup(msk, (struct soc=
k_common *)req);
+       rcu_read_unlock();
=20
'''

=20 - Refactor the mptcp_pm_ops_init to support reuse socket, and put the
    mptcp_pm_ops_release into mptcp_destroy:
'''
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
                              struct mptcp_pm_ops *pm_ops)
 {
+       struct mptcp_pm_ops *old =3D msk->pm.ops;
+
        if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
                pr_warn_once("pm %s fails, fallback to default pm", pm_op=
s->name);
                pm_ops =3D &mptcp_pm_kernel;
        }
=20
-=20      msk->pm.ops =3D pm_ops;
+       if (old) {
+               if (old =3D=3D pm_ops) {
+                       mptcp_pm_ops_release(msk);
+               } else {
+                       rcu_assign_pointer(msk->pm.ops, pm_ops);
+                       synchronize_rcu();
+                       bpf_module_put(old, old->owner);
+               }
+       } else {
+               rcu_assign_pointer(msk->pm.ops, pm_ops);
+       }
+
        if (msk->pm.ops->init)
                msk->pm.ops->init(msk);
=20
-=20      pr_debug("pm %s initialized\n", pm_ops->name);
+       pr_debug("pm %s initialized\n", msk->pm.ops->name);
 }
=20


static=20void mptcp_destroy(struct sock *sk)
        /* allow the following to close even the initial subflow */
        msk->free_first =3D 1;
        mptcp_destroy_common(msk);
+       mptcp_pm_ops_release(msk);
        sk_sockets_allocated_dec(sk);
 }

'''

But I think it is a large fix, do you have any idea?

And as I said at the beginning, it seeems like not a issue attached to th=
is issue,
could you review the v3 code with ignoring it ?

Thanks
Gang


> --=20
>=20Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026081912562=
9.49823-1-gang.yan@linux.dev?part=3D5
>
