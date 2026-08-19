Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FF24BBF0
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139189; cv=none; b=OOBKR73NJzdUQcx6Ikc4DCF0p7mCmOMzswjBKPhilIoLmS0u7IWTGq9XPinqqjf/HB04hZDMT2dMeBgmXKWvi6U4Rd20SkRRvGJvRzBTjW3Tre2F66vGjRMUz7VPZjSvnrNYZMxXalY9WsvqR9GVzh1rsvL0W5NAoYcVXgFdCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139189; c=relaxed/simple;
	bh=b6m1+qVhABuFrlVs6DYZZ4IRjI1OiItMKcizRuJaxJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=tfQWM3SVwMRFmdCdhjFn/gO6dJdqqovc2OUOZ4c74yYHumtDj3LS/BobjrMyTiCSO1lgFyXg5ubDILA9cC1mv98iDd8pnLmsVHxQ3rXLMhpAn0zqPGPdhT2qEwyrEOtlwDrfKQ5iV11tcxNfoGfEqam8f7YgUfmzh6skKjvJekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIUZ8pFI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIUZ8pFI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf452def93so17470125ad.1
        for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787139188; x=1787743988; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OY+/Trop1kKBH3XCrZFgmSEbdJQBqPWZde5wxEySjWA=;
        b=iIUZ8pFIL8cHA0P8gM8RrZeYcgVOtUf1yjTithdQrkjrDa5p7DUHeNcgPhANl9XPDr
         69DHKaxzySjKvh061gUOVGgNbBXgZ3m4uCgsgy/HnHYZIfJIyA/MzQyhGtiVuO6MOTru
         j6cY50UIBINXunnDTaRu8uIlTX4UtMzWDSSj4vaDZxqGzZpbpB/a0ybdslrBX8ZW7DiR
         1PTc8NI4K7lxsk4fpMa+dWyx87dPbwYMC5nrEnJvz9aPlTlOhPL7tIsP+JZ9FHSrQIC3
         hvdQ5v2ItDL/+f32wGi9QPfhRPVqHY1/1RaWbCIf3ECIjLYrI3NKt01m3Dago4SYjWKU
         KYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139188; x=1787743988;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OY+/Trop1kKBH3XCrZFgmSEbdJQBqPWZde5wxEySjWA=;
        b=onhkOfQugh/7yxmrg4yqWD2oloZf3nDCltDbZWLJtYRAZEYkcHhRCi6R9RUYYhl65K
         GqVzLYRh+8F6lg6c13qtcWrnmdZvIHTMnBM4CA7MtosmoRbj6zcpFgvxub5RpCL9OFLM
         jpS2UgIpgli58JLKUJOe0FFdhvIHVGgHeO9dI63rLM6oSLdeNsSoomY3UUikftW5y6C1
         7M8bflOwmR9ny73LbPlzWf4BX1HbmEngi+36SYIZ9ngu4nYpcouVz5rKTD/Av0O0KJSN
         Ohec5Rh/XfDo5a2NsFHfT7dhZ9r6sgnnu1QAtv5ogaCRw9VkjtfKZTHDeK3PrDcYsh/x
         1M5g==
X-Gm-Message-State: AFuF++kIaAPS6Uum0QCJNVFdGULt7lSH/ruPrZ/fxRXkJBi6P0qo5f5r
	uVmYr7fEVii0G2hsrVttjRbtk/JnK6TeoTGZDc/jZOxGE8ztShS7FmA=
X-Gm-Gg: AR+sD122hf3bhTDuypnvMs4d8LE77PmlOK11xw6AIeCV1NHFfySAGtmNYbLjockUOUn
	e2WouYA56Yoz4Fu/UPI38JxUKvig5R86z85EybV6jqRPLygrmyyxvK+NE62ntdCsaIT0CUR67n0
	Ta95ANxObpdGchO0EdLDlNZoWWfwQJRs4Ag2I1lpehvgsnW3ZXB8Y3kZ4m3F8H5xtCmf/BQ/GJs
	JDw8LG2onIk3QTGgyXT23mR7IraoB08aIJOdl0xUUrH6s0Vh1TamVEtIgj7hR7jmAkpON8/sppO
	3AIkiGzMjjzIvzdVuaPIFlkx+P2vylUbS7kmpqZSiqVOcC+4DqancKD1FIpvJMyfXiwDmwpFrst
	aJnXurgnwBBEypYoxXhbNOqruu8o5AkT0jKKSksyJf1Th8SfFT2MgC9ZKsTb0BpjHCHEbShXJoW
	HBsTrpoQrCdmUAPdmIEzRC51CjQqkpNeKVAgFJ08L0T8OXxfQAT/5mxzpQZsOKNaOALaKAEVE=
X-Received: by 2002:a17:903:286:b0:2cf:7ea3:7cf1 with SMTP id d9443c01a7336-2d5fc8b42f1mr49280865ad.5.1787139187549;
        Wed, 19 Aug 2026 04:33:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c2a92406sm5140999eec.11.2026.08.19.04.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:33:06 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <aoWBrkNwebJe-koh@v4bel>
References: <aoWBrkNwebJe-koh@v4bel>
Subject: Re: [PATCH net] mptcp: fix use-after-free of the subflow context
 on the delegated list
Message-ID: <4e931bb8-ef6c-bb00-1399-05580a21c53e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:33:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hyunwoo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/322442=
40048

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/113b7d74e31f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1148376


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
