Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F61A9B53
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568482; cv=none; b=Ez6qHso64bk545LRGoB90grYjQ8+Thm3bIa8Re5eh1nvH4c7OaY3CTOxSg8JWMkocFOWaM32I6NozCm2kZN/mZklYMIKvObQ1sCT3WjtSAgQITZkT01b5rBDRjK9GsTaqZ3XYLV/1QipIWiMDxwIl0iC8gbdNrY9XSwBPnNeGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568482; c=relaxed/simple;
	bh=ma3EPt/hMnxK+8olq9zbUVxHTOPtAYwr+NxBjeFcZlQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=b2Z2IGPSUYtlczPD7FFYhwhzsFcDUQwcYaefmC/BhwnVTfbGIeI2Ff1uz9kim/16MGI5VAiHj1WrNQVGShaYGUC156S6HOWQCABzCKyoyNxck6YfCIgyQhQuqGH4MME0XwrNf8xCX0cfpvY1LsCdfd/zyVXC+JXt9Z+JD3XTQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANkV15d2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANkV15d2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so117112195ad.1
        for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 06:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735568479; x=1736173279; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK1l+U1hXEzdSr34s70cv/xFBe+ZdAwKdADjnaFbffs=;
        b=ANkV15d2E6wtSzkJDKNlVu0GYJ/jp1iW6t3vNqqdgZv1vgsLRjdNYLmjmDeCceBWQx
         4/0iIpGe1ELOPT2D7WlWvDtQN28yKh/btFGjUR3VihBDmMA0R25Jrc3nyOsRXqeOdG4D
         Rnt7ijf7TkgrwiJM4jc31NSzy8T6J9alxVUVAh8JN3FCmYV/qXMdWrtzzHq0BoY0l6uu
         B/IpIp0pR8xnK9msaVGiyKEIkQDXLSlwddEkPJrJC2zSRqWVAR1MBqCRkVsIOvs7EFrV
         CX983a7IE0na14XHrT1MUlUw/Bd1C3x8vJ/HJv8aDLdwzjRj9usjkn17vQrNsyYtzGj9
         w4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735568479; x=1736173279;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nK1l+U1hXEzdSr34s70cv/xFBe+ZdAwKdADjnaFbffs=;
        b=McJQeYENmkSigb06I9dP/jDDVlKMDx9tLOaXRa33C2UkXhomGnm/dGpG17kpTjWRZ5
         l6HazNeX2U+ldaqtRXrRxbGHFRrg8TqDdpYdKAacITDyrM8WMuMrfeiv8vdZtwkq/HSc
         gIvxEEs/0bhJqpXac2aiEnYtvalK4lINWweq0MmM6XwSdQqzG340ZMiDruW6n8SW5Y32
         cEh7iY75SFDue0GWgWDbnYJQOyF/3u+mG9suIe2JsYsNbYFo+LvstTkG5WkdayZA9HSN
         Gv8uqVySgmLfe6SSrYX/1bomYyYT0cwzpnFbQFwWv0xGLBTHe+j1vbJtt/r9qMV3y4XU
         h6kA==
X-Gm-Message-State: AOJu0Yw9lqBmAK55ktUfMIhf/R6aEP91nleERBzM68LbY38WFdzwxolS
	2mn6jMO2WpYOsD1hLP/kxiNN2ndyZ3tZgmYwOaRVVBjrF7sg1UI=
X-Gm-Gg: ASbGncs9T/u6bKC/svcAbgWAoh+JXTMDcZ+DARwCT0ZiXRS8AUrrrbO6epirNHnNuqA
	1L3zGn1+jVj7eqBxznZ6jiYTFholAkV5kKpworAqLnoB58IfEMLWuz8zjUkjeySR+KW+5HEXPHw
	x9hbTVg6hp3d+3xAnQg89CLTiYAfyTzubGpf33ol6rAwb/Jhyy5htZ71sitOIRV8gUETvJDu2hv
	V+1FWTIo+ohg907jUfB66zvHOTuN3IGJQ3ys6UlfUa5F9V/EfxxHMDycCxbrL+5P2dG
X-Google-Smtp-Source: AGHT+IGXE6jbpI67YF0kuKLTAGkN9grqGTNh9FLhjq8jW2+kLXqz/qxenvlJz0iEviODLJ9S0L3QmA==
X-Received: by 2002:a17:902:c94b:b0:215:ae61:27ca with SMTP id d9443c01a7336-219e6d6b172mr611174715ad.26.1735568479421;
        Mon, 30 Dec 2024 06:21:19 -0800 (PST)
Received: from [127.0.0.1] ([20.171.70.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97182dsm179502485ad.82.2024.12.30.06.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 06:21:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/7] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
Message-ID: <9b181abc-552f-d0fa-1b04-39599c6cc9eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Dec 2024 14:21:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/125473=
35119

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/70fec43cc6e0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D921412


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
