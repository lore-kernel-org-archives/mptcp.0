Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0903239DBD4
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072083; cv=pass; b=ZrrgjneXVfCtIfISvuMRXMDBmWG5FbGpk/0GFcX922g2/PWdHkgdTZGP5+5xmrk4LGrJa+9YdrYu1Dnt+8nglwdnmxlVr/uWlQnXKFmQ2sgGvzDjWfzbHXOLYDxPACAm9jAqYweN2tE7ECgN8jzwSO4HtBAiMNNWV+m5Sj3YpAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072083; c=relaxed/simple;
	bh=oNiv+tsKTWLYIE/EjhupRwce02ExUpYqH4oSfSZTuIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tR3IAVIugjnqIz+6iA59gG+5X7r/0LnhQIcBKsieqT0KPSTTJ9bfoFdYdUhZ6e7gdK+Euvi5ktOKQM1SaCe6eNbT/NzWkrWZJt5RZ1MBYsZG0G7DJGqAXsvMzZl/L9flKhhmADDzPL3DyCpGa9/ExUh/9WxGHgLsjdpt5YWcb2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=bC0Kxa3m reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="bC0Kxa3m"
ARC-Seal: i=1; a=rsa-sha256; t=1783072074; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LBxJj+ZmH+8i0ssn1aO5BHMknIFsM7wWm97H4DkM2+aGbuMldSYhaX+/oKY/JMjft22/OML4TKLselL9QUoXhPUDfjfwQQJ8F3CsCXGC/FtcwRnJoRTUNThhFmVSzkKPpvmW6fcJAiQC8uTUcMFilDsrBlNWi9cX2GpoN9Q5RZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783072074; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=St41nlpjVzfnOcSxTciHbNDDYrrl9z1yNvKolaJdq4Y=; 
	b=mlJeyQdkmSaDqoSZWiqbcwgG9bKUt8DrQTTKcAPYLkZEm/AlWCKf3+hMgopSGgfhozq1cHstZT71RGTqVXKJs6WzzFpK0Fz7jiZVMeQ4Qx9CMHuEvZs3GfGlkr2UQZLGgpZ/E8vJzQC5JsiCMcQgjIY8rzwV57T3CuBef7IhOwQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783072074;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=St41nlpjVzfnOcSxTciHbNDDYrrl9z1yNvKolaJdq4Y=;
	b=bC0Kxa3mZ0I6C9MF1cB5I8F/i052Or9BHcXnc50syQskMwuUqWKj0y/EnF6HWDUB
	gaUcogGi2tKzGKJiWPS3gcPXtP4VIFn2/bYaft8xdKzA7yrMaIXJfFSB6N0PflT5lkZ
	idXkZIIjRbnoHChvdwvcotEP8qrQzJrR5lqpgej4=
Received: by mx.zohomail.com with SMTPS id 1783072071519186.96991529551474;
	Fri, 3 Jul 2026 02:47:51 -0700 (PDT)
Message-ID: <6eacd2edccdb626a972ddf05d3399d6e18f14eeb.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 3/4] selftests/bpf: mptcp: verify scheduler
 rejects non-msk socket to set_timeout
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us
Date: Fri, 03 Jul 2026 15:13:57 +0530
In-Reply-To: <5188aca74aaa8ce3024e5661cb493f49cb690170.camel@kernel.org>
References: 
	<20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
	 <20260629-mptcp_bpf_kfunc_fixes-v1-3-8cc875f36f53@mpiricsoftware.com>
	 <5188aca74aaa8ce3024e5661cb493f49cb690170.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

On Thu, 2026-07-02 at 14:23 +0800, Geliang Tang wrote:
> On Mon, 2026-06-29 at 17:37 +0530, Shardul Bankar wrote:
>=20
> I don't think it's necessary to add a dedicated "bad_sched" BPF
> scheduler, at least not for upstream. It can be kept locally for
> verification purposes, which is sufficient. Therefore, I suggest
> dropping patch 3 and patch 4 from this series. Alternatively, if they
> are intended solely to validate patch 1 and patch 2, please prefix
> their subjects with a "DO-NOT-MERGE:" tag to clearly indicate they
> are
> not meant for integration.
>=20
> WDYT?
>=20

Agreed, they are validation-only for the two kfunc fixes. I will keep
them in v2 and prefix both with "DO-NOT-MERGE:", so CI and reviewers
can still confirm the verifier rejects the type confusion, and they
are clearly not for integration.

On your other two comments:

 - Patch 1: agreed, I will split the bpf_burst selftest kfunc rename
   into its own squash-to targeting "selftests/bpf: Add bpf_burst
   scheduler & test" in v2, separate from the net/mptcp/bpf.c squash-
to.

 - Patch 2: I will add this in v2. The wrapper will fetch the subflow
   context, reject a NULL context, and require subflow->conn =3D=3D msk
   before calling the helper, so the passed subflow must belong to the
   passed msk. Thanks (and to Sashiko) for the suggestion.

Thanks,
Shardul
