Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C0318B8C
	for <mptcp@lists.linux.dev>; Tue, 17 Feb 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771321528; cv=none; b=pgA0I+ACNitmy7TkcyNvloFc/SyGIfv3tNH6mCrPCf3uC/S49yxmaCfmkUm7yEQ+4K2Ws+e6uCyVVTXkdWnMkhgSOpIk3vqWHyphySITwe75sB8sMNzd5GlNBIF0Yyp3vtSC0mybV4mxEKqVs5Nc2WRyGjw8hLRMIfBr3BdUdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771321528; c=relaxed/simple;
	bh=80ZjLDoAg6O84zQGLgtXaMtBkSkCzGtkGj2eIgHjE1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nbp5KMMq8CL9NcdXj860gbMJR/dVkftEeq1JqopHwQnC2/wae2AubPhBHvlzzW0dmMGJoOFdEf3g9G3idu56C4hGXzx9BZu5kBdiK4pzVA3pcb4I01HFaX1YoYV0TNbWRW1ryxrljRykfpj7YeI/MkMgErLUK204X3KAmo4qa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRx/86Z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRx/86Z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771321526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9s0y1ovOo1BZFM6x3/T/9dr9qWpfR1VROZWtKFV0XFY=;
	b=PRx/86Z6YHgHb2f8QtFTEbxCwtf+whhPyxCVNGCSpcs34ElUgyLpU+xrA2qmo1t2EkM3kE
	nVIIMWcZdVOxTtfU802T2RMAZdPhTLV4WdUMHoi3OSOA1CcIfBIKSgSsAJ+N9Jm6OaKBhu
	s16yiHJzIFjyVDJSUsAIeEaz82yWoZ4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-nrpYpdp8Pp-t_FL8bvF5Mw-1; Tue, 17 Feb 2026 04:45:24 -0500
X-MC-Unique: nrpYpdp8Pp-t_FL8bvF5Mw-1
X-Mimecast-MFC-AGG-ID: nrpYpdp8Pp-t_FL8bvF5Mw_1771321524
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43630b02fb4so4451392f8f.3
        for <mptcp@lists.linux.dev>; Tue, 17 Feb 2026 01:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771321523; x=1771926323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9s0y1ovOo1BZFM6x3/T/9dr9qWpfR1VROZWtKFV0XFY=;
        b=ErC4c/fXUUS7khdj5FjUDMLIVOyXHTdOlBlx2sV86tZgahNt/8Mq1v1D7aFbTcN+5b
         yjjuYd1nxfN14HXsudN8kyVpWe0364q7+FtmCeA5u0O8iH50bWtGb52cDMr0X7kBkHYo
         p1vAiESK1R9mWfHB5BpFjoOwP42NrMtyigzEZ0NMSG/j91yMIKZeabCVeBggdTGjprmx
         +t5TlwxZOq5/fmThMRhF8RvAwWBAF8RT23CRTblcLsn8KHF6Uf8nFG/d5dJbNkyGptrC
         cTUzM9mYs+QxCceIJxLRt6Yw9yY05jvycgCebptgcb5HPdJZOG1vzGp0QulleiTaKkHm
         TpJA==
X-Gm-Message-State: AOJu0YwINCFCZCAgEIbWTjMFEdM7hFCVXg7leHfPBXGzLsShduAS9Oko
	1QSPqyFe42FoiDpckBv54OOBAgCEdtdeWMqemrHwzAaybwc8FBQT5++CeJh2QBxbeae79uRBwx8
	XemB//30e1tVwEeSesTQniFBhM3vEiVAS+NqxjzpF3nrh3QDcOQwfDwutl8NOClfSMCSb8BAans
	FUzxyjqmatSVo/0BQ1bJYD2aj3UmywSc7oscNXAw==
X-Gm-Gg: AZuq6aJkv8GpIb6GIKwWimaD7CqkRH3pXuEkjNPVYI+q0bOCL0K9faM5/2yT8pr4BvC
	1dbNvrE0XrdBEQLNwdzxY9uIoiyttaCiaH8zZe2V0jMZLYVK1etbOt1AK8GxJnIluDzZ5gpZIUS
	XVrh8t9I2deiFzVwDaXs/CtYyMc40nn3quriXdTlffO8qagHIrKtaw/SLHzNQoKMpmMDS+qFywL
	sIvdfE3B/pXgBAvamqK2z2w7myreQpvJSW1KnMUFx3yzChJOGmiWhkJ16JAxp8Uv0AG6Pab1Lyt
	PN4X131xjQjk8ekhzC1361lIEXanfvVNS5Xet10cmCWpwOtNUbhoEBeRG1vXwI+wCZXPo8H2v7Z
	JekIcq1+0huGFJo9whWS/BXbHuQ==
X-Received: by 2002:a05:6000:230b:b0:437:8f98:8c93 with SMTP id ffacd0b85a97d-437978c9a26mr21701435f8f.7.1771321523238;
        Tue, 17 Feb 2026 01:45:23 -0800 (PST)
X-Received: by 2002:a05:6000:230b:b0:437:8f98:8c93 with SMTP id ffacd0b85a97d-437978c9a26mr21701388f8f.7.1771321522505;
        Tue, 17 Feb 2026 01:45:22 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad112bsm33457733f8f.36.2026.02.17.01.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 01:45:22 -0800 (PST)
Message-ID: <a4f25306-0f9c-4411-aaf3-e2f2d12ca0bc@redhat.com>
Date: Tue, 17 Feb 2026 10:45:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] selftests: mptcp: more stable simult_flows
 tests
To: mptcp@lists.linux.dev, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
References: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
 <604e9832-4fac-b3b2-dfa2-e40e481cf94b@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <604e9832-4fac-b3b2-dfa2-e40e481cf94b@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lT6J3-aaoreEA_iuA28q14YfudhRyMGpwiVbRB-dgTw_1771321524
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/16/26 11:31 PM, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
> - KVM Validation: normal (only selftest_mptcp_join): Critical: Global Timeout ❌
> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_dss packetdrill_sockopts 🔴
> - KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at boot time, rebooted and continued 🔴
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/22078199700
> 
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/92395bd88118
> Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=1054688

It looks like the CI exploded above, but it looks like an infra issue.

@Matt: do you have any insight?

Thanks,

Paolo

