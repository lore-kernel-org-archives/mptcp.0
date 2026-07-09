Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F830567C
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618482; cv=none; b=u6nBd7viZzvhdz4vInGTBTmNB6mBRmTjbCnhz2sRVcBGMTWs57xmMshPPRrDDTOrCbihtxeVMx4+rEsbcrcbdD/+nu2X1/gJw0DkikM4vUYBz/fsSrwsd73UIvAGRK4NV13gSqBozNJyxjMd62lVwPro+AipWhub77MSri5N4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618482; c=relaxed/simple;
	bh=acnldvUNeT74JR15pjOM3WH0K49MdaRkGBIbsuAJHs8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=iJFPNP//JjOeY/NibiGe5zF/S35wC5DKBhVO62x8EyBBcaAsqqm+BtAp6PbzT3SEsJ1aHwZOy4jizd/jQK1ZZN0A1PXxyBRozBwYVFUjS0wpHjYNjMpDGvmLA56WorQzgp5/0hxD01zYxp9Q3rKdcw9brvD1PdDlKGmPg5IcDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIH3iR0O; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIH3iR0O"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca12086c06eso93853a12.0
        for <mptcp@lists.linux.dev>; Thu, 09 Jul 2026 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783618481; x=1784223281; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tK0LdFSVZLpOOQcJW9McXj2K4RqXueHUPP9KbkE52lc=;
        b=sIH3iR0OkFZ2SRvr1WB/Fi5xp2tAaunxTYbG91OePDe2M9MkCzyT3rh3DdhjRROshf
         oxF24lAbHQfFEvOOII6CcNdyuSpiS8LaRfE5asRNLepR8tSqk+5WQGDhXbef4BVXv7U3
         mUOQf6ghFXEcNSbIObIuawbKyNjOCsAwe/6vZWe86zgF7bJYaFVzte3j8MMQIueR1Pe6
         XOxJ/00w9N/XOb8DRoyaWbdo1gJnBu+3OTlq93mhx02mjLbW+CVjdao/rlSjJwr8NIvd
         b82jcAJkuvdY5kJ5ZwdpgCDZS695/Rcmb9sqgqefE5fMixePbsN7CX7vAheR6wstek7R
         2SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618481; x=1784223281;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tK0LdFSVZLpOOQcJW9McXj2K4RqXueHUPP9KbkE52lc=;
        b=BMPrlTCzHue/HO0qp8dC3p3SaYttTTZ+Fi9kCMgkUAWiUTgIJCl5MS8yqteo3LUaH5
         F9TNbkX8fExoPr9+D1W7fWO2nWNLetENLLyQsiZkXNjGFUnrhsum8wpzCsEBJj32HvtL
         k3UQC24iKdbt6lGxOHXFJqpoD0NEX8vAnhiu88Nhb6jDARsEquJG6xSEOn44sHk9eQ5C
         kjbgMIoF/eg77qI2pK+VBR2pyPdZdvaoz46IB4MFaOdt78GRtM7NKouL978PuR3Sp8fi
         vdkcBS7E/hkW2ffNFWxp6tjaduQiStytS6vtZUCjLMOTxzKbaRzaLpZw7uX0l78KsO+C
         Cyqw==
X-Gm-Message-State: AOJu0Yyi4h6XyvCXPt4MGeGA/IlUXqYujRRm1Axxz5LFrsI/eLN7Uxf9
	awBHieRUmHhQ+ficu6Z/qsqDtnrV4fXmM8eF/VihV8HfQGLjbesrG5c=
X-Gm-Gg: AfdE7cnlkb4ANFckfvqrDtY6FRJ53BGSsZsk7xJRASHUWEYi6kXNGesMgEAu/DICgXc
	gvPzyGLi/49pjpEk74OTQ4OvuK9uNNwBpiaBWkNMPUABSYFgYOk7OIqsUmb4Fz1oR1Zaj4UfI7G
	PlA9QgR4rozljN4bAQqEWkSHWGxzFLq6oEqkfTrz+WGPCG1YlJVB4/ZfywTvS1GF69Mh1EVQiVI
	07DRb7icDSArV7npR5sgLE6nzEp1u8nmZzKLukMSRvP/nc2EJZAMulDlrJ+Q16Gde60+El2XFQB
	xS2CAUjdwiuekkC/fbt1AVdnrkI23yksImFyVOMjl0pRCbDntTnjtCkI0eyOrrnZdP0twV9G4pZ
	53GXxz0HmRCU/rnJk6q/Dt2zDDUBSONv41Ktgo5th/d7EJbxmPstSY/6xDK3wy8m/OqqrjH5AvW
	4puLvIU6P+J1Ddx8RMhFjGLF7SSf4bRZtPE4MA90U=
X-Received: by 2002:a05:6a20:a11c:b0:3c0:b4f8:bbe3 with SMTP id adf61e73a8af0-3c0bc9ba23dmr10987815637.23.1783618480637;
        Thu, 09 Jul 2026 10:34:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.214.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm30510323c88.13.2026.07.09.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:34:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260709-mptcp-harden-combine-opt-v1-1-378b0a47c1b5@kernel.org>
References:
 <20260709-mptcp-harden-combine-opt-v1-1-378b0a47c1b5@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: avoid combining some incoming
 suboptions
Message-ID: <acbf948a-d557-ade1-6fdb-89d6fc968a81@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 17:34:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/290339=
74586

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cea92aeb202b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1124826


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
