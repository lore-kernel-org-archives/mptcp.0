Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DE368D43
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333804; cv=none; b=kMKNCcU3gOQ87Umzl7QwbqbpQiKppYvLB67X1SsbEwOnJJbB3RCfjRgeHPSRf+AWzSQlORAgrRZ4cCHXPRQ5IaBqHmewuFQb/Wuk6EzdeFXGTQ6W4xsCGS7FK0IB4ckXd+DnlrkCvMqb77AmGVovG8NPMfpzRZtCZXDkaeBb3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333804; c=relaxed/simple;
	bh=cOC7ZqGtz59cqv+ouGNiUVA/7ubihZ4+LjJPTyUOuUA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=SrelPlXuOGWTnz9HcPaXM8spGB9V+bglA8RtgfDrRxLw50pLRenInOEH/YihJW4ch2ekKtBS6veeDCPtUdhq7Z0IU7tzzMIaFw9vTnEwKnlbp1gC2v/TbTL+gtYZWbI70JG4i9miVDqVCcz9o6jzcVhr7dZyUADzVf+dOogWq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SdBd+ngt; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SdBd+ngt"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779333799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRoLV7tMmLnxccjXrh0rcoWpYBzf19OYqU/VeyvdcKQ=;
	b=SdBd+ngto5PA3frVhRz/lZC8zhL7tgiS3lN4rlfx1dx8J+lT0fFnGIZsSceTqQP855Yi/Z
	ErrUjQRESxgcHGbUCdlebQEZaGAaSuZKrf0Tl1LNm+lRXsJIFnh8Ldo/zibCOz4pIf54S4
	pb39lva4cgjouWjprL8FC83fgA1MmPY=
Date: Thu, 21 May 2026 03:23:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <6eedf75be575a1db987ad5b7b8226bf0f412f37d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v7 mptcp-next 0/7] mptcp: address stall under memory
 pressure
To: "Paolo Abeni" <pabeni@redhat.com>, "Geliang Tang" <geliang@kernel.org>,
 mptcp@lists.linux.dev
In-Reply-To: <5b4149a2-fa05-4f72-bb8c-f3ee82f07d63@redhat.com>
References: <cover.1779210016.git.pabeni@redhat.com>
 <da87a06afe83a817fefdb86882b6d68169ba121e.camel@kernel.org>
 <5b4149a2-fa05-4f72-bb8c-f3ee82f07d63@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 20, 2026 at 4:19 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@r=
edhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 5/20/26 8:32 AM, Geliang Tang wrote:
>=20
>=20>=20
>=20> On Tue, 2026-05-19 at 19:01 +0200, Paolo Abeni wrote:
> >=20
>=20> >=20
>=20> > This an attempt to fix the data transfer stall reported by Gelian=
g
> > >  and
> > >  Gang more carefully enforcing memory constraints at the MPTCP leve=
l.
> > >=20
>=20> >  This iteration presents a significant change WRT the previous on=
e,
> > >  avoiding entirely the collapse attempt on memory pressure. Note th=
at
> > >  this choice represent a trade off: collapsing allow much faster
> > >  transfer
> > >  (to be more accurate: order of magnitude less slow) under some
> > >  extreme
> > >  conditions, but makes transfer slower and much more CPU intensive =
for
> > >  less unlikely conditions.
> > >=20
>=20> >  As a consequence of the above the `mptcp_data.multi_chunk_sendfi=
le`
> > >  test-case needs a 240 seconds timeout to complete successfully:
> > >=20
>=20> >  TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
> > >=20
>=20> >  The solution performing data collapsing would need similar long
> > >  timeout
> > >  for the multiproc tests cases: mutliproc_even, mutliproc_readers,
> > >  mutliproc_writers, mutliproc_sendpage_even,
> > >  mutliproc_sendpage_readers,
> > >  mutliproc_sendpage_writers.
> > >=20
>=20>=20=20
>=20>  Based on this version, I actually tested the MPTCP TLS self-tests =
and
> >  still encountered a few similar errors, with the test duration takin=
g
> >  several times longer than before.
> >=20
>=20[...]
>=20
>=20>=20
>=20> ... ...
> >  # # RUN tls.12_aes_gcm_mptcp.multi_chunk_sendfile ...
> >  # # multi_chunk_sendfile: Test terminated by timeout
> >  # # FAIL tls.12_aes_gcm_mptcp.multi_chunk_sendfile
> >  # not ok 3 tls.12_aes_gcm_mptcp.multi_chunk_sendfile
> >=20
>=20Without this series you should get some stall there, right?
>=20
>=20Note that the 'multi_chunk' test will require increasing the test-cas=
e timeout,
> as mentioned in v3:
>=20
>=20---
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_data.c b/tools/tes=
ting/selftests/net/mptcp/mptcp_data.c
> index 39d092e7888d..127d8b47bd39 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_data.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_data.c
> @@ -166,7 +166,7 @@ static void chunked_sendfile(struct __test_metadata=
 *_metadata,
>  close(fd);
>  }
>=20=20
>=20-TEST_F(mptcp, multi_chunk_sendfile)
> +TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
>  {
>  chunked_sendfile(_metadata, self, 4096, 4096);
>  chunked_sendfile(_metadata, self, 4096, 0);
>=20
>=20---
>=20
Hi=20Paolo,

No offense intended at all=E2=80=94 Geliang and I just wanted to confirm
whether this performance regression is expected, acceptable, or
something we can optimize further.

We tested the performance of mptcp_data.sh (time per run) 15 times
under the v7 patch and [1], and the results are as follows:

v7 results:
5.82 4.72 5.38 6.18 6.52 6.04 5.05 6.49 4.78 5.62 5.52 4.91 8.07 3.87 5.6=
1

    Max: 8.07s, Min: 3.87s, Avg: 5.64s

[1] results:
2.98 3.44 3.11 3.06 3.78 3.23 3.28 2.88 3.52 3.33 2.89 3.33 3.91 3.20 3.4=
5

    Max: 3.91s, Min: 2.88s, Avg: 3.29s

We=E2=80=99d appreciate your thoughts on whether this delta aligns with
expectations, or if there are further optimizations we should explore.


[1] https://patchwork.kernel.org/project/mptcp/cover/cover.1773735950.git=
.yangang@kylinos.cn/

Thanks
Gang

> The timeout could be reduced/avoided, including the 'collapse' strategy=
 from v5
> and previous revisions. As hinted by Eric, collapsing is a sort of weak=
 spot
> for potential evil peers and in practice causes high CPU usage increase=
 to the
> point that in debug build some other test-cases will still require an i=
ncreased
> timeout.=20
>=20
> AFAICS the multi chunk is really a corner case, especially when sending
> 1 byte chunk. As a trade off I prefer avoiding collapsing, and accept a=
ny
> solution that allow completion in the multi chunk test, even with very =
low
> tput.=20
>=20
> Side note: I think/I'm reasonably sure even plain TCP will have hard ti=
me
> with such that case in comparable conditions, i.e. when OoO happens wit=
h
> very high probability _after_ that the sender start pushing data at hig=
h speed,=20
>=20but the upstream self-tests (rightfully) do not include the OoO part.
>=20
>=20/P
>
