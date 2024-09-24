Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C483CD6
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184276; cv=none; b=jsV3BGCNqtENNcUq+JAhsCqL29VutvJvcSBCtKK1VSHSJOm9pK7C9GDTTaydXM/slNN1AcZeuti9GA38XJF4hLu1jIaOsLtydGJtmyn5Ew7JMD3F6yzGJ+6jX0vpgA5kt18+rPOYG04u18PzdCOLMrrpAUvk1po8m4YeIaU7U28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184276; c=relaxed/simple;
	bh=wAS0Kc++ZOXbHWvb4THz7LazgSMmQ+Y/6QKvlUiOIDM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=o5HxoCR2UnJqufKVNy6LlOntYiC+oUsygtHLVyKIHj3H7WUiID5ucIanM9srYLlV5GUtzjyUYCckGaVpk6zk86uF/mFz8WQ4dKvJTawk0Kp549Rvxb8nWA1KfWj1Kyp4KzgIBv3UD/4xLmK5hHNQH+XUBjoORmOKRA6j8Qjo/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew+IGmjw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew+IGmjw"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99fdf2e1aso693495785a.2
        for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727184273; x=1727789073; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAY7TbJVCHAgGVLR2jtCXudJR4DlO6sjkMqnjGp1GEU=;
        b=Ew+IGmjwnbMv9xcV0GCEeKET3GqB5zkTq4EJuqq7Vx/Ux0VtHzYx9Irhi6TGg+dsKc
         JWO+0lZ/Rx7ftONjYx1HCHhyqsoxwE5zFY08vBfokHblamw44tQQ49aCmQhq+lgyus0i
         NFJoGmCJ2boVWylFUo6N9ak2AZOoc4A5Sl8G5vD3bLOD+WZnuL1HxlmPB9IqOv48hvdc
         i2ctozAShh8jiEZOjDWhGwnSWV9dS2DGerLPL0+bJheYe/W6MwOteQ9O+W6A0REbhPAR
         tOr1NwWz+AV2yusd53dx4XapvNJaNHC5vCg8fhpL1ny67e7cboqrEGLdsgF1Mk3PMyJm
         /sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727184273; x=1727789073;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAY7TbJVCHAgGVLR2jtCXudJR4DlO6sjkMqnjGp1GEU=;
        b=tvCtAbWxFY2IBP0KovWxyZALl711vQdS/sYg6zUwJ6KrZchk+CVQ7x2HxIzAadqhYF
         akdM9YmkdBiEwyXzp5t3B/kbOy6K8vRCiU1cIcODTgj2LtBN/gWgCOQNa3igRrQULePR
         EPptWY14f6yLx/x7V7WGKjSUy4iNd2PEiY2nz1pCsQs5TLda5Rm6Q7R6X/ZbLOMb3dCj
         RYlSmouOPz9pEduoo1FPbAQLy4jFKstRLD2FqYll2CgUEmlJSrOzx8rDCll1LTPN03x8
         sEmg4Q0ca5U4E8uWPJ1OjUHi+EB3c83xfGY6vQ9M9i++xX1Csj6zLH31ZSCzqsDafczm
         Ey5g==
X-Gm-Message-State: AOJu0YwhMf0eF0VUvmU8g3iZoQOcnoJJiNMHDfjRCgzqDkp3Rzh7efou
	DrgH9+cpIK/U6oVsBTc/Fgxh6PBU7PoHJMwo6USdV6+SQdC2c651yaiH
X-Google-Smtp-Source: AGHT+IHwQisgct0KpNLVROWDJiwYvft724xJknp7JhSt9afcO5OQKnyaZvLjaKYiQVjfBJXp5c7m+w==
X-Received: by 2002:a05:620a:31a4:b0:7a9:c360:642 with SMTP id af79cd13be357-7acb80b8676mr2660888685a.17.1727184273378;
        Tue, 24 Sep 2024 06:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cd3fdsm67773885a.85.2024.09.24.06.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:24:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727180731.git.tanggeliang@kylinos.cn>
References: <cover.1727180731.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] drop skb parameters in pm interfaces
Message-ID: <acd0389d-ae45-db76-5af1-940ab935249d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2024 13:24:31 +0000
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
uns/11014017392

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b4dc8db2435f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D892457


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
