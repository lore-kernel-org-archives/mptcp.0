Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C769306D2A
	for <mptcp@lists.linux.dev>; Thu,  2 Oct 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403977; cv=none; b=KhgLScVkFQHVpA0QFARzVW23Cv5/WiHjuJr3D8vY74oNVcU8jq6sJXvw11bbHsaXcVfLN7kvd66q2/tUovWOyh0tHh6/eJLTmwIUA1XMM8eZwy/gjobrV1VaxbBIqGnRcYf3PPsfoz2+MfQz7UECKtXV1dkxb/EDAGT11/7cWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403977; c=relaxed/simple;
	bh=jnW0WHk1GTDuFbQivtHLAaEF0gM8WzI1319yM1qoIno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5INHG1UIKBX+xYr/TGFEwY+IUlmXLfuuEvg+D8u+QWPLpxTanEVDqBNLH8bUbYQbUjOsIgpIyI717a29drE4/UV+o1WH/mCOPZiqCgFsm/mAjR/4staJ+zzpjLiUno4kwU0TblFrEZNko3aU5uPoSZnPntk8Z3tL/1fMdHrPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bfy7XIZ8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bfy7XIZ8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so9666325e9.2
        for <mptcp@lists.linux.dev>; Thu, 02 Oct 2025 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1759403972; x=1760008772; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMea/o0YACa6PU/JEYi87hdh+Mb0Ql/ZIbRjPDYQCy0=;
        b=bfy7XIZ8exHBWyzSNvXJYElfW8FibPBrM0KAm5NKAk3WF+mKl55rCAmzenguKk7I96
         Oruh/WzVdzRRuRDfVVlJd2R9yiYNHIdhsMCXsFg5BwgWRT5Xb+frxVv4TKA1cY0760EL
         MfPbzAP+1s/iXKSAeMaCVBraufWVtMpGdzmpdlG+QJFQVfF46mEIu3IE+kyA0Jzd1wqS
         sNOHWqZbgWetxf+UFKQwa3iEi6oR2433k6eHQkodi7wosoicr879b+f8GaCAf4m2HRjg
         QZfc58Tf7kCaxYO4kI+6uIgpRzlsiJ7Me4BTyCQQp2C9ZHSK/HEdlffkGY7lRBLwVJCd
         49NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759403972; x=1760008772;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMea/o0YACa6PU/JEYi87hdh+Mb0Ql/ZIbRjPDYQCy0=;
        b=UnEwL21nHPPRmfTI03hVy81MwutYRvWziJT7/0cHWwyD/I1yjv87tv4ENxiFrxDoRL
         OFE7lUFdjKM7WS2S1+PJymahu289EsGBNRP9+HSK1ewBh1gR5rP47LbJgf3MLyHS/Jb4
         /zbqIZDxWk2Rr0OD61m2X+mDIXLpMFKEBTX+9Pt5voUT8N7sFIbUSG5xVbJOOWwUU/jT
         K1cXubl+1QHkNzVOF0I2+7V1h5BElch8aPP1b8BDWXdKhmFqykiKOBv7+cFkCtNZBXgb
         7kTB4x78bckwV5s27HgZs8YAT8tqKs1Mb3G8+4p+jiZWlp0RoLghHYvxgve2JvrG+pip
         vAtw==
X-Forwarded-Encrypted: i=1; AJvYcCWponu/30D3XgJldfvdOP7M0C/ghmmPokhvK+ayUkz006DKK4k6tWDZdUtea7hpCcOiiIpBYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzydCN5er5oyWY3M/iev5lnYsu5MOcomngZWnWz3iROf+xQzuxk
	TMksLjJ/FwexCiDoY/7OHksBM25rV7JLprjpz/iCQKoHCUGrAgwXwo3OZengYKxG+EpJTPH5KEL
	8UTNLk1Q9MITJOUbinKqccjx3+I/noyZ5TU4tNRJHHWfyamzAtg==
X-Gm-Gg: ASbGnct+w562UxbNdA04yT0a9rH5uS33urAVW5XHx9yFFqcleMOXiqrCWfhpNt0gnSs
	zOpRYCHCA4MGojjaNgug/Wsh0o6PyEXgtPILzQ4cfLqVvN1jeDYuU2pm9I3mw399g++3dws8ptG
	nj2fsZYW2PNuVTnEElpaxPaCDXXDrY8nkWqeUuG59418hc9+kVzaUNCa7k2ZiFuMvnrq1U4dpPO
	1ZeKH9VAscq5p8nakQAo1Y2udNo4x7B6ldscdJxucAABSmioctSO3EEZFwSZPiisFrTmvDXbp1p
	kGHqrrqZnh7ryIQSIvy5zRgn7DhNqUgAP3HHkXrxEupeE0ad8XOamOwnlTANH3vlnljJoac6TL2
	WQKRZvz8H/lD84EU3fyWZhyJPuzBXsECttVYYw47NyOKFiMG3aFu1jEDoY0IDSazfUPPhekbRjM
	cJqE2viJLHCg==
X-Google-Smtp-Source: AGHT+IFHjRrAgQahzC7e/Z+ad8H1shbYDsTGKyNANpwhGEYiMDTuEHKQ8Zb9f1126LzKrRHkTxhI0g==
X-Received: by 2002:a05:600c:8884:b0:46e:652e:16a1 with SMTP id 5b1f17b1804b1-46e652e1dc5mr30118425e9.7.1759403972475;
        Thu, 02 Oct 2025 04:19:32 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9bfe:b0f3:b629:60c8? ([2001:67c:2fbc:1:9bfe:b0f3:b629:60c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693bd8bfsm30851485e9.11.2025.10.02.04.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 04:19:31 -0700 (PDT)
Message-ID: <4099a03a-22ab-48e1-85ff-c8b7d0288e70@openvpn.net>
Date: Thu, 2 Oct 2025 13:19:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: sort configs
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, shuah@kernel.org,
 kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 phil@nwl.cc, sd@queasysnail.net, razor@blackwall.org, idosch@nvidia.com,
 yongwang@nvidia.com, jiri@resnulli.us, danishanwar@ti.com,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20251002015245.3209033-1-kuba@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251002015245.3209033-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2025 03:52, Jakub Kicinski wrote:
> Sort config files for networking selftests. This should help us
> avoid merge conflicts between net and net-next. patchwork check
> will be added to prevent new issues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Antonio Quartulli <antonio@openvpn.net>


-- 
Antonio Quartulli
OpenVPN Inc.

