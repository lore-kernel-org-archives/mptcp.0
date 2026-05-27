Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354A224B05
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859017; cv=none; b=i9c1vz3XEPjcaA+ng+sPLJp/9a5SGyUzhuoYJzJmaviO309S5v3fsbxyS8UlbK7iskqb/FdXBagYWsSIPDtTMX+1qd+4ZpEPbtdFg7Ro/Cf6ySNcQzC49soFKtvMcFr4aXCSrQbf5jbFC7szvLzXBPDeM6OYl4jv5aHIhU6dzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859017; c=relaxed/simple;
	bh=q2a8/LzCwP89xw2hlNJ4CeDkb9FXkCsXYbwC7G34sgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=KZZnltsjfMzHHdVipMyyPGcNfLIf67u5oT4VceacB0g8jYwb6XhLwoIdkGsrWB5/lbjMDM2/9nFtxwufsX/RauH+mZUn9laoiu02HJdllMpjJJl+Abe225gvn/XpMXOS/DZfsmp1KXIOKsPQG3KD7R/EXV7/iRvfpSbmUVdmFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQStYCLZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQStYCLZ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-516df7b256bso21377781cf.1
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 22:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779859015; x=1780463815; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vwEj9lDg2YxJEBG82MbRDYoUK3D1LiNym+ky9IECjg=;
        b=iQStYCLZSyCMGCBV574DopdMYtDvqxPzYVVaZ3/VznQugOlzvCMbFZUtIhpnyzrEh4
         xzVi62rVLEgcpfPW+akpav2wSpRG+ZmzM8B9yDyR32003pY34IXptsmoTtGuCNirGgd9
         mw3TcNUwg/pkUi+nsfkYtNkcQb8JhV5NkCm84/HrcFtlXtCgyp82FBkGezUeG+92AWkm
         EMa/5c50jO7710PpJ7HCD52xoGNEm9UDok7Zh2wIkk899KH69Q/qvknosKT7sB79guqX
         bBVDU1gN4JTDYPt8tXIVRnH9QIEqLV253nRYYuIc3BZYwZPiqF/UtghKfu/njvNp21o7
         MzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779859015; x=1780463815;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vwEj9lDg2YxJEBG82MbRDYoUK3D1LiNym+ky9IECjg=;
        b=jH+qk1wQTptM0gzH0Ka1lFV4NJEAWmxJTLAKiXbQrmhr3V55CNAG9yH0Nqpk7G+4OP
         mlpmB/LI99dIavoGMsuUmu0xd4Bi+ob06jPtMTbyPnIJemHGUdbYP58ZpYWugRqSEX6y
         wd2gLVcpUQHsqKCGwjejIBLqRaJPZuNS83OPg9x42FY7PqKuqHfW1ZFxS+2DeUcUomAJ
         17H2jUz6B12yAtx+zNSTsQ+C6oyMgCcJAvK/jRugD8xzj1I/D5qnOmB3XXfE2wkajbgI
         mNBsPd0/gyDr37ZxmxaYQ54CJ8xrfvqYTvCqnuE5ltHRUq8pRdjfrcWoodmE8sdR1yh3
         XSzA==
X-Gm-Message-State: AOJu0YztjL93bGFbJ5BRZc+lkzcLnwN4/9UoUb13vreazQF3+bsZayi+
	27I4wdbQ3uGb/zKZfjqcCNZTmrFgslliVchzINyDVF7ttvK4xDYCo1CbZstt3ak=
X-Gm-Gg: Acq92OHnus++kMeg39xursK7pzl/+kW/dPjzWTW44/SE5mMBC6goL8dK7u5HmGsoHM8
	+PcMNJsb1qNSuojUcXkUozH7w8kkkOa6lxpNIl+BnMOsg/frITSGEJ+irlKWlqRpld8LKHfDtVO
	M6kJsJMlN2FiD+KqpAOAVSv0witUSzBE7rrhxvaqsp2kicxuNySdcVbbLhCeH4ZoGapWNpiQeKt
	ZcCXy252gXD/G8iEv8r4u8e37HnIxPqUzVF0tlVjmDE2+5FT6yOl+LU/YWORTDe3uQK4Hvctk3R
	LFBypKhVeksuLdBgTOKAgckwpHLlGViRN86zHtWjEJp1072bu7fkpjgS2Uic5+bsfHF3RhsAuVp
	k4Mw6pv3hAh3SyGsbwlL7Tcr63ga64WUt5cAuHl7iJdjDQzRhpr8zChU7aJSk03oXoJme4jyQk/
	hS5ts8byMApUXtqD4ulO4yJ78jcLZ+gOsunQ==
X-Received: by 2002:a05:622a:1ccd:b0:516:d64a:e67b with SMTP id d75a77b69052e-516d64ae927mr298772831cf.40.1779859015352;
        Tue, 26 May 2026 22:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.14.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a0be01sm40330411cf.7.2026.05.26.22.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:16:53 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260526103647.732350-1-xiasong.lee@gmail.com>
References: <20260526103647.732350-1-xiasong.lee@gmail.com>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: prevent add_addr timer rearm
 during teardown
Message-ID: <eadc6fcf-0045-9869-4c28-c7d708f5b7db@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 05:16:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Li,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26490120648

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f75fedf58a6b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1100863


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
