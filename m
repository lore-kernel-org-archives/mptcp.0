Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6404C74
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725856490; cv=none; b=XWDn7ud5iVylldWGfNcg2rvHvmWTeEXQP0EgibkNl0XkKUj4CTBJcz5Fhx9qgNhaRYDm7VSXIE8VzqiM1dolx0KKx+j1rszMiYoxUTdmj+EkbsHPI6JeibFZBTk4ndbc7FaVE5mLr9L4vIjyYgqFdvNAtNlNFh76PX9Lsjmhjts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725856490; c=relaxed/simple;
	bh=e1DvljF/KQrprtCo/2iOLbjA9CSlppq5YNcWqUvVPkM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EMvKA35gk7MmucT3yGo3k7/g5jSOMhzzqHm6zYez87nMvU9U3n1pNG4WZGxClJeZ8HNdqmqX9fkKp7mZnnryK1LFUWpFjv1WV76KDaM3DjISymejnvqFRt+6wM0tEnozY8wttwhcRZM96BkTZoi6KHVP4x0D0Rku03X4fGsbw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Um+1S+Mu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um+1S+Mu"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582a0b438aso9128691cf.0
        for <mptcp@lists.linux.dev>; Sun, 08 Sep 2024 21:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725856488; x=1726461288; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hWWlZcf28XPRdA8dACs9pDVfpajezPCAf4Zfgbzzao=;
        b=Um+1S+Mu6UuUQrfhea3+GSix3ZUxKMq41hfrYLtoHydraD42C1wujNu+o44+qFcaYA
         qCFPO96ePvIWMZ0j/Nd1G/N9ki+tMW0awNlSAsp0DTseRFxvMT/8BjORV2kk0I0Ikor+
         wwyV2oSPrsGyN5J67p4pc9mPyYpHoHB6Le+mf+KRCE/828WQblcGvoRssLqKhYRBZjSB
         BC46lobClXFc+cdPSmeWMEpJrx98cIZSNUtIGD9O5MJYSHG1CbdkU4pWJaQQAyRcdPDs
         zT5kZJZwps7tkIxyd0iI+8mgsbT1bBXiZogeQkaYA64uXR7Cia3WJrSvmDQxeJNQGV+K
         i9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725856488; x=1726461288;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hWWlZcf28XPRdA8dACs9pDVfpajezPCAf4Zfgbzzao=;
        b=wMTs0A1UTc50gw9dbPfg93lJIS2kKK7XwGbX58te57gB+YQUtbtsb4i21j3AIx56vR
         RfjdqOzBfTe4tHdiwmcBt3dbhP5GN+/USa3W5onvI8OehTOzytiafgxhmBd5+GHViNIw
         ANtRaKb6guUpsoftniV8B3FNX5E6Rh6NselSnt4gUtOUpOdJC4y7vyeIPeHpqvuolnXR
         e3dJk1VdZVRCHUPCRQeWMZ0Qr1BFUWUGXH6sWSDLBwKKEZVDwYvqhhzDvxQ4EWBx5Nbv
         Fcs4qsuKMEvCM8+j2Uqf6deynWnP3LUGB0MTPfwhIbG3ofijd7fLCbsNj6lzjo0/Q7SI
         KyDg==
X-Gm-Message-State: AOJu0YzWEJaygoKW0yXfU716Owh97f8U1rgI8sB3Wkri2etahklpjlV9
	cUJ/c24wqSQ7/cu9xL+BsQCzADCbGZh2vIXK7l/0upvkGogry4fdCoeP
X-Google-Smtp-Source: AGHT+IFc/9FgSmysIS9Gl8dEF8VvMo/jiDF8Wn6xqWl6m1fTMzQkGnWFuoIS2PAzzMpd87lklmamig==
X-Received: by 2002:a05:622a:1448:b0:458:2a24:6ed6 with SMTP id d75a77b69052e-4582a24719fmr79967131cf.21.1725856488085;
        Sun, 08 Sep 2024 21:34:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.37.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f61ac7sm16938791cf.71.2024.09.08.21.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:34:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725853370.git.tanggeliang@kylinos.cn>
References: <cover.1725853370.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] update PM event CLOSED handlers
Message-ID: <5ece1524-b88f-1db8-0128-1a480859d4cd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2024 04:34:46 +0000
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
uns/10766245271

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/81049f6b01c7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888215


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
