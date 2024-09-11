Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33338FB0
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025217; cv=none; b=ph+FHRCLVloaSUDH6UadqHpbfwpq+PJ4SVzExpV1Vq6W2K8hDBGqnYYOLzsJvsq/PlhVB2LWrMYVNGSL5qQIdq3sQnxpZ4z+HwRxSlJmaFlBTVpMs+PUSwHdYxSwlmwOxTNiM2ZMBJykHfk1ynM3iuXhT0sz+wsH9tjWlQvWTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025217; c=relaxed/simple;
	bh=qV5nLn4dCFBE71p0ixAKi3rna3T5qsv92RR4qefluSk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nVmWRFnpRT+m/gTQAL/OST9WlnvmqqltCdsxztIo8lo1bH0Mztxdmvs5qCOsVhcYLSDdRu1U48/2MJ0oAbATNOjL51smijGR3z5MRF27qJdRrK3RthY7NEwBovG5fwTADzW6/v/2b5sdtAslSP04DcqtLEOWrTsEYq7WnbfwBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJUIOu3s; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJUIOu3s"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9af813f6cso309259885a.3
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726025215; x=1726630015; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79M314Cj6ydBzbi68Kdra62IdV//JXaDeCCnbAmD+6o=;
        b=cJUIOu3spp020o7jzFZ5l8pT3nA594VwAKRJZFSerKVIFFdy896n0a33nUGx8FUWJb
         Fwnfjb3Esk4azWjXgnrr7t8nfwYkD/3o53BgqLMMvkyAaEx1XXsZy/QdHYyNMG69UQNY
         lxN2rq5XjUvv9iAwuPeEWlVhNEz04jMY5MhW1R2KSp1+1JnQ2872oOf5V/X9FqFPLdSM
         0guEiSR/aZurIsjeJQXZ5uEzcfAra67NhyST8P2eSDB6qi8yfyq026SrGhMHnCX/Gv25
         vb2MhrsCbVu48BfDe66DOjMxjwigjnc9QwB+HSvl9iARRkt7Uewlk2Q2eNmTzCSefhoK
         OMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726025215; x=1726630015;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79M314Cj6ydBzbi68Kdra62IdV//JXaDeCCnbAmD+6o=;
        b=Vb/Sd66pyL5w5NM+77i6QB9hMRWwShO3vktpbuVCR0H44MSmgAWBDCB5rjaPUTv1lF
         UjtcL82hnibIS1YBERv7UAODs6ZLdK1QjZLOPAsDXbHQHhKOO6jLEfxQX/3FH2kNL2Zk
         uh0whCWRybDZWiPuINh9sEx6MXMFCZ+Jxhuy/CplRF8Y/Lji8kYMCNCvMEmqeuetib1t
         ZwJYesDKDNsjZBVnPKyfR7k/FwYS1o4LJPapVhak3PUmwDkqpmn03UqF633rvjX4WYms
         B2vlvAf6eFtrpVrhZyFoBcgsnxo9LvNml24WTNKwwpa5Qy7vFqrzoHPQDzMlLsZsMC1h
         xlKg==
X-Gm-Message-State: AOJu0YydScXUk82xPeI/85NoTjYqy22WI+fuQA69kZ2buH4jClzugd0i
	BZt16qGT5ID28KRvZN+Gwxz0vOIZpS0CLN+J90z/bUiaWlLUt3gvhtqH
X-Google-Smtp-Source: AGHT+IG2ZjvVgtAuyFNMqFQ4wgZK7jxiQGfxJqaB7GAH4j6AvEVCHv8eEMKtZOR1XQJfI/0EjmD4Sg==
X-Received: by 2002:a05:620a:448e:b0:7a9:dbaf:ddfa with SMTP id af79cd13be357-7a9dbafdf8dmr42375485a.51.1726025214484;
        Tue, 10 Sep 2024 20:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.210.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796ad20sm369170785a.32.2024.09.10.20.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 20:26:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726023577.git.tanggeliang@kylinos.cn>
References: <cover.1726023577.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/5] add mptcp_subflow bpf_iter
Message-ID: <9e8585ad-c303-038a-9ae9-c8c041371e60@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2024 03:26:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/10804410957

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e8=
2320bba409
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D889124

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
