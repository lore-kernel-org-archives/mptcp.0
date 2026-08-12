Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10A325704
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534104; cv=none; b=O5mtrwHGoYo3MxVsRQDaT7YY6zipIszdlsgGDSmAhRmyaTZ5flV/b8FVMjocJ05RgWMtW5zK3l8p7oUMa1yYmgv47UG2Vvb/AFmBLkgBfM43xToS2dUGjyB7H7qmUcptgwslZTRlgEZmihWuaMWg7nYzvHTI+L0FUm1rfm3lP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534104; c=relaxed/simple;
	bh=0QKeIyePB588C+c8Ooblije5l1+xiQ7kLZigHWi2HME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfPYKVPwROeXMMLOpdnRip21ZxYfJawBu4OQrgywAsZcbSNcoSsk3A2PtLa3Zz5msQqBNn4dcGV3lIPLDQyXDUh96chCb6acpja3Tnj4zCIOfItLKr+ZyeqYwAgUq0OssGD9iSDgTBHU+49RhZvg6mRn1TQ37WeSmmvn6zYpUrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfVBR2Bn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfVBR2Bn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786534101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHPULlvHQXf7Q2xtlCuKwg/rj3hPtbwEgQlH6DQjHB4=;
	b=EfVBR2BnaA1Y0pufRO+fLyEw9DoBnVN60qG5mI1IfQR1mIEU5SZMPPv9rRl66jfKN76xfp
	6xvmJVZF5qRuyH96gl2/MKjwDMPmg0wIUzFQ53D6Cyy78fCdJj7J+le+5HMlhbdQiSOVfN
	w9RbysZEKUElIXyN2mX5qPacJr94lAc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-BwelX22COHaGZ1hcqp7nrA-1; Wed, 12 Aug 2026 07:28:20 -0400
X-MC-Unique: BwelX22COHaGZ1hcqp7nrA-1
X-Mimecast-MFC-AGG-ID: BwelX22COHaGZ1hcqp7nrA_1786534099
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4997b060af8so5488715e9.1
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 04:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534099; x=1787138899;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pHPULlvHQXf7Q2xtlCuKwg/rj3hPtbwEgQlH6DQjHB4=;
        b=rlrhw8gyHpNeJirvULWTAIdli5ZRLng6TNrqaQ4pGXDQE+ZaKxkq68UpTUTQPWT3Ra
         cZg1+QM6TUHrlFUnhNAFHDtOWLFSSw3V0cOyVnf1hAzldKeLZ0fNMCpaSRi8nTFPDG/L
         u/yyY7S2gd5CE/zewsvV1BprJhGtxT/wpo79hU0vEOrx+gI7dUV5f69pkHATkYC11cEe
         z7GnW0h7uVeFI7je5QNJVV2Bsl2O3/3NzAY411nE1TOHHvT/8uuxNxfDQ/EFOJt8ZBg+
         cLqcLUT4X8b0lkIJFXBBpAsngatDqVZkSNbzpckZ/AW/w1DGbhMdfY2bBviwrG/+q1vD
         HhkA==
X-Gm-Message-State: AOJu0YyQhwN83xb0laV2JXrpR+EutNQPEEGzrg2b7rHHUGISVRIv9a1e
	io7ODRC4X+U+PtfIWOwLfjM/pJurPuQlm64snhq3p5vLGz46YJvL2JaJIsl3V1Qmc0JMFDUdjyR
	uzr+8yGK8OyWQ7gTR/TrWpXEO4qoH0Gm5+eAaKv/KGisa4dU0RR6RN3RX5qtPN80w
X-Gm-Gg: AR+sD13fFL6z2JTUGppAlzeAoewxwpSVr04tDWQrtp6f+f78/N2HBeQPkF76M2boo0I
	NhR783ywDn1epCJOE4bBfW0jMXk6u1m6VlRwrhlEK5hmnrJPhPL36xepK4t+iY2dn5tbEcVK5L1
	F5U70iHxou5C8TRvO29dT9Rvsac652aQk3Vuz8ckln64OseaT16esspaDakBHEsBaUCgL+vJw5r
	UrM6oishqMco7FqiEEvLX9B/qsB3HjC8zt+7xbCYdphEG0S9ZAnpU6tmrtKBJuUZ+TefB+f3sus
	dW0db8ZbjQI5EGivfnopURfGbNJQX3RN8csSie2lphb2fcb3l0K77mMsS4jAXfdfMekaNM53ojZ
	57OdhlFPdqhswhVibFi+SwuxifGWDgO/O1j0klRD+K1xyB9zJ1gN1/eayKYkh6I0PW2YWaQCrof
	g=
X-Received: by 2002:a05:600c:4e4a:b0:499:78b3:7b34 with SMTP id 5b1f17b1804b1-4997c0fca3cmr57615665e9.2.1786534099294;
        Wed, 12 Aug 2026 04:28:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4a:b0:499:78b3:7b34 with SMTP id 5b1f17b1804b1-4997c0fca3cmr57614735e9.2.1786534098837;
        Wed, 12 Aug 2026 04:28:18 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b35a3eesm46889725e9.4.2026.08.12.04.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 04:28:18 -0700 (PDT)
Message-ID: <b268a8d3-aa21-48e4-a6ea-92e98fa506c0@redhat.com>
Date: Wed, 12 Aug 2026 13:28:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-next 7/7] mptcp: implemented OoO queue pruning
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1786026372.git.pabeni@redhat.com>
 <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
 <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
 <b0d961b3-7a06-4237-92b2-67d8ab2ff28b@kernel.org>
 <a8cf012f365d1885f773d5959829cb42298477bb.camel@kernel.org>
 <eb437699-4e3a-422d-93fa-3efde2985189@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eb437699-4e3a-422d-93fa-3efde2985189@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vqeQXFybnfWx43twtTDbwvGd2EJzQPkNgTg4OFcunMs_1786534099
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/26 6:34 PM, Matthieu Baerts wrote:
> On 08/08/2026 04:31, Geliang Tang wrote:
>> It seems you forgot to update this on the export branch.
> 
> Arf, indeed I did, my bad... good catch!
> 
> I just fixed it in our tree (and the alignment of the next line), but I
> will wait for Paolo's feedback to know if he judges that a new version
> is needed for upstream, or if that can be done in follow-up patches.
Could you please revert the export branch to match upstream, so I can
send follow-up patches?

Thanks!

Paolo

