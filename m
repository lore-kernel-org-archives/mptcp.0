Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135241D62E
	for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065623; cv=none; b=CkrdplXNXka4LZlxjqpQdhH1Nov2wavR07cM+DXsiDIGERAGkQzwGOvS+FJ94UxYRZ4Mn39PHJ+KuDB/qpIhCTBD4ZHUsk2yfJhr/fEWLBDBfjx3DGJJfZGE5DcVL2Cp1bvRByDZZd8hPjKMvYNZWBIs3pz8ig7HoqFtObLHydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065623; c=relaxed/simple;
	bh=D9FNIb9pLmP/ypV4E1vaoET8og1P5tgFuwMyqR8stJg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Ok3ALje8h32l2oLJ8q2JxS5hxnFMGtkHNVk8TXBcb7KGFIw+DYx56fkoKlvxGujahlBkXVkzEMr178Gnqa1ppP2R/JtTQyIgisPLh65OagOhgBp6Mpmt9NjxCgRAhtOBeDSRp15I4pQNXFuvBig1TyvQGIoFDRgHgQ2mW5MsMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rW7Mzm7z; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rW7Mzm7z"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939eb3249c1so321381885a.2
        for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065621; x=1790670421; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3u9ikuQynvL9yXjDOW2acnMa1WebeSU9oHKffpWNOXU=;
        b=rW7Mzm7zTu7MIJCwdxi/TjLWn8ZDO25HRVWfD92io3UNuy3gQ1kA87vzhHlOBam5Mo
         fWL0X7x9WvGwfe/dnIOvYXvwMJz+H4licLbFyJiMVmI4hCpmGAR840PR4YMalNv+VxnA
         0vqFOO+QFvoLT+UJZT3oYML1Bmk4hbuhkKoRjBQsGnYPSB0iNV6FSWuZygqRa9b9BkBA
         hPLiR2FCmXZ6pZA7a4iqbC7RPA7eBiInPmu8nwmpx/KzzfI1xRd6at96x6vX8zW31a7d
         hAKNX1Cs6SG3HcVPFqaKy6rgQkrCO3I/PwKTJXP0r4q0bVzwY3Te7PLSGFT7p4mADWc4
         mw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065621; x=1790670421;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3u9ikuQynvL9yXjDOW2acnMa1WebeSU9oHKffpWNOXU=;
        b=RYuRNVhkjea8+ECIO7ZQLE5AYIYCbZXU/J3tVmBE3X/PpTgs5hozyfN/J0BnPfA3rY
         05aI3l9gTRcSONI8z0dHzEPojGCdcQF70rX008VL6+oZIxjNozEsGzOD4tEdLpQEslch
         YGFq0/2Aqkv0z/s1Jppf1EZ21nEeSnwclsgEX5ja2ocWFok9JTXRmw/p/ZKO97KhFw0S
         hMfsz7jPM1tSro5DVrROVCwDzKjUSK0/dN8QFHXbi4aKRAGp+5l8+z10JAWZvNTIkN9k
         XekTiy30gs1zRgNCpme5U+yLPBGlr7v8P0VWbsSQkeBaZgLDMWBJb7X5DgZ1cpodQWYs
         7KXg==
X-Gm-Message-State: AFuF++msnP0BkgSNh2GP09zY8CbITj5zsRDBwCrD+wqni8oHZAmOAfZe
	SOCAJk2fl5QfaG+YiE0boP0CNl+wdh1ZUcjaknPBO9n/nQWzJGpr6rF4JjFa
X-Gm-Gg: AYBFou0XAhSyarvVekGo1++De7fXKH67q4ElJkWFuBT+9POiKeW78rQ/pniH9pMsmd/
	Rq4hFnY/51FSOKOFZ15/kPe3FSqH6bWYjDTOMSWreuUNOR74Ph2oVOAPKYA1u3CenMcuMRoVtu4
	6Vy4RRH4ITW1HvCDxpqHcQNPMjEdEo+QcZF665SA0Zfp70iZT++ItAKSkFLvgXL6JK/FNuOXWgB
	h5tTCE4R2Lkzwq80xGlkd6/gIDPTTfEdkKrzX0qcR/MoxojjlZClk/MZYjdOLl78v6yFHmuBoy2
	Bh+0u9esX4UnLn3GxRQz1y5hec9gicen7N5d92zIEdQBQF4bV6YttDzzChuy5OOzTgALpNVWorO
	STGHukMGD8wQmLkw/ET8IR1+SB83oB2ph3pJJ3xpNhlFetTrGpyTvpFo4Ll4Pc2sAMBuj1HpiYH
	XYYs7mY68aCHuP/JUWtf+iPEMwARgTB0JPiT77ES+DM1wjkyZhCV8tEkygSQnhoTu9gPPdfZVpP
	tMCjuZv6f/T
X-Received: by 2002:a05:620a:2b9a:b0:93b:d79a:c469 with SMTP id af79cd13be357-93c15ed1182mr493733885a.65.1790065621205;
        Tue, 22 Sep 2026 01:27:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.87.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d253165sm84471985a.46.2026.09.22.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:27:00 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260922071245.1997430-1-kalpan.jani@mpiricsoftware.com>
References: <20260922071245.1997430-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: force a push after arming infinite
 map on MP_FAIL
Message-ID: <2865a6a9-ee6d-107a-8500-2c17c1b8876f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:27:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35700537880

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8426663fc7=
96
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1171057


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
