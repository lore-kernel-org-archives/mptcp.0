Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8956550249
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835624; cv=none; b=FfBv5pmlOgVHyRdsImDIZGrFLxEJ1YwELZaUrHbAxoOsKxeyniuK71IknCjP5MpAPZ/ha/j9FvphAmb/fRhrvQJTo04F3VxBxLrkdFAh1THL5Z24Ic+bm1t9fMRIlaDTQa2ow41wxdkP0Vq+qULTdDaSXz7z72P3OSq+zPlrLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835624; c=relaxed/simple;
	bh=S2c2kj1ee0wYzu+fJJyl2mXpRfoeG9KvSy666WrbKwM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NP/sTtUWmOJxyAML8owyohWvpzzKBUAKILULHXiLodLtlgImvw7N9YQnanSKy+JF+k7ci/+gJcDLxwNKCYGt3kpxb/nfnXjkW0tfgEJ+2DIlobTifwPJQ90IpIAlt3zjN1JgCS0ko/Xd/hOIjhtkHIgh6cdZzYCSQekVmPWg1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbO0z7uV; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbO0z7uV"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso4866652276.3
        for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710835622; x=1711440422; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZWlmrnjhfsuIDGnXhUbYvJgIFBHZ+tPkizqrEHj7WU=;
        b=RbO0z7uVrigK67pYKB+qHU7eBHI7yk9CxHYfOv2Yc1sK40duBlqwyaCZY2lbUEGK52
         BpOTccrClUpPlGOTIFU532TyjNdrf82FSZh69cdfswBQA+MU38jIrk6arFgYqArHBxRJ
         P5qqoHVcmTqS7o3h1qGrjT/5MqJRt9V8GloGXIo4NAKHD9BNn68AHskl3pMKjHHh38xn
         81sOhZ6Bt6M2W+eqO+qMfSmCAPwi0CsIzEGADP93WO5YwieRZlhLqwnsQe1cz92A+Z+v
         H2/hknO6GUyIDPUuBiameB2UtFky/8iqJGWBFpV6zUjlZnmsJNqgcOm88jVoM/YMUJGn
         J59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710835622; x=1711440422;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZWlmrnjhfsuIDGnXhUbYvJgIFBHZ+tPkizqrEHj7WU=;
        b=qYYzlr3ZFHQlPFDERzKBC/YPDGFZww9EKlVzvGLlFTU7t18RLyICjQheu+akndkPY9
         CYh5ReeE6Prfq10QwhuY1nbNzPAK8/F5ozVX09GfQvQ5kt7NBWfgEVmMB4W+KVd/Pbx8
         /dbxybJb9M4ABItD8FhDP4sX6dA8H28q7JWVpLL6YH7SM7vlNI8atl7deR16gCxKJSvs
         ug+AlVF2kucnu+3F9L51kc84zI6gBF5QtJRax97CfYfo0AKAqI4z92Zfe/2G3JQUmbmM
         /ksHC/yJk3+tRtrrkWeqCws3AzDQCLGOCaGvycsGpIiCyHCLB5LdGuX6YNElhKU8y9yv
         vwCQ==
X-Gm-Message-State: AOJu0YxmXFbFP+XRnuWYZF7AdBIaufUoA6OYXlkTBMxwWe1CzrMkmXNi
	qsAv+vz5NLlfnpN8q7d8jiYbeiRKniwFRqltAzhUROxKLVcDgVOSWIzwPkE=
X-Google-Smtp-Source: AGHT+IG/UMY7agsjBcJ74+ttOaAPyyK51cjHbNUjSCYMYHl9wVU8FV1d+jPZZjlPGkfybbAcu7mBhQ==
X-Received: by 2002:a25:84ca:0:b0:dcf:3580:8bc3 with SMTP id x10-20020a2584ca000000b00dcf35808bc3mr11571901ybm.23.1710835622493;
        Tue, 19 Mar 2024 01:07:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.94.33])
        by smtp.gmail.com with ESMTPSA id bb2-20020a05622a1b0200b0042f541ee072sm4482331qtb.4.2024.03.19.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:07:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1710832493.git.tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/9] add helpers and vars in
 mptcp_lib.sh, final
Message-ID: <9729f8a2-31cc-9668-b1a0-2cef38b6bff4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Mar 2024 08:07:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8339177200

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3de9bfb424e6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D836322


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
