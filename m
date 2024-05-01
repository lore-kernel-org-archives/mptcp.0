Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D912FB1E
	for <mptcp@lists.linux.dev>; Wed,  1 May 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579031; cv=none; b=kHXeLLaRwzEGKQ4MkcCESg8a58+2XwOwOL9CobhSWQXAa/dWoootZEr2fuLVWpkPIqsBnqRESvIh7gTx3ZrGG2roYwYN9ioeT4Mx+Qnms6SQ+jMIkLYwYQdloVqy3QpNjK70IW17L9mT1ljEbsVgA5d91r6LxbQJn4xUNyCmOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579031; c=relaxed/simple;
	bh=ckoWfyyPNvCGxi2fVomdJaaX3vET2oCk2vilFXck1oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mve1SLSzeXTPC6pHk5seRXGehaXPv9DGJ2/fKdOkwYfdruv1M3Fa3oEOIKiuA0foLOT+4EjJve6YawkvT8n1voSvtBWkCwWadlpAJvTZ6IJmm2x1cPo1vmpEXR7mXSls/1LVIfTUnb2Li2PE5Saz18yV14LoJojhNxI3NE4IGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCUbrYvj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCUbrYvj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b360096cc4so110297a91.1
        for <mptcp@lists.linux.dev>; Wed, 01 May 2024 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714579029; x=1715183829; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzfY/kmW53uOWAjNU/h5BVe0MuVfIdc+r+3hv3BH8NA=;
        b=MCUbrYvj3c72RIB4u6lIrXXmZH52pC/4oKt8sZTlSct09/Kzatz+3nEgpxaScCe/AN
         dXwPEuwKN9DgMR+MyDzAKWanrGF5JDjen2/ayEWqGg53lmedqMrwORf7k8kEwd8Pb6fN
         s7f+GMaWHwxecspTH2EVZB4UBuIp4FJ6NgbLlH9RNutM7La0mohDphKhyzwBgXYH5IPa
         a2/KHlx2ycrEtmeEI26ik44k1h2OcAt7a0M1u0lHRE7dwvodtwl2RtHoA4Cy66/BD1qw
         wiigBq0xb5IPjTw66D3WV3NUWhvIsI3XIyVtHVM7sonS7MHCPjEKlzIcSE99zdi2UGqr
         KV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579029; x=1715183829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzfY/kmW53uOWAjNU/h5BVe0MuVfIdc+r+3hv3BH8NA=;
        b=Da0LeiFlDLSitMaUTB5yQDi4WP3GCiQaXhpXsnHtvTjsqCESNp9+uD7DYavC0+ZKR+
         wq0l+CAo8vWAG4ZbHnSIB98bhVOJV+H7cG3/8GtRv6R/nuq6Yzqmse4CaURFNt9b7fcd
         EpVNZWT5yNItSJSpfWq6+T7QsECcPUICON3M8GuprDTddwUJFL7KdhgIEO8fFOsNqrTO
         8XakV1R5EFPCTAITLez+QbTpkpFqAQWOaQkLQXm8XLuGwPl8oxvMOER9M9YQMPuMHHkd
         tQd+pEe+x+VQXSEPk+K684CyjTAPb59JqUPoJOa4JinxUk6hC/xJ15qeLOGCqSRn5qik
         fmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWczgz9VhZrDzcdA7V6iM6GeUAY8Q4c+15sxbbTthiXakBsslpb/3f7Jr7ilWwx+4f00qHJ3103nBlFAypcZs8f7VR5JMs=
X-Gm-Message-State: AOJu0YwmslO/omFnpSN0dT+mJENknKSYgfQiJei9aTnTOvhcq4VJwET3
	ybLNk/E+h8WEywRYyx+WZ6PwInK9V+VE8pE/m/Yz9sopnInfLTOh
X-Google-Smtp-Source: AGHT+IEqUo1eBvHR/WvPzsLh02ckKC0kjNX4dU4g0A0KwEIj4AgPLsyI8oM8EjDjFw9PvnKEhB/wtg==
X-Received: by 2002:a17:902:db0e:b0:1e7:b7da:842 with SMTP id m14-20020a170902db0e00b001e7b7da0842mr3016504plx.2.1714579029330;
        Wed, 01 May 2024 08:57:09 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001ebd7bdaaffsm5820761plf.288.2024.05.01.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:57:08 -0700 (PDT)
Date: Wed, 1 May 2024 23:57:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Shi-Sheng Yang <fourcolor4c@gmail.com>,
	Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
Cc: Simon Horman <horms@kernel.org>, matttbe@kernel.org,
	martineau@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: subflow.c: fix typo
Message-ID: <ZjJmUcfDioUzX2Gg@visitorckw-System-Product-Name>
References: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>
 <20240430180057.GB2575892@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430180057.GB2575892@kernel.org>

On Tue, Apr 30, 2024 at 07:00:57PM +0100, Simon Horman wrote:
> On Tue, Apr 30, 2024 at 06:50:33AM +0800, Shi-Sheng Yang wrote:
> > Replace 'greceful' with 'graceful'.
> > 
> > Signed-off-by: Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
> 
> Hi Shi-Sheng Yang,
> 
> Elsewhere in the same file 'earlier' is mispelt as 'eariler'.
> Could you consider fixing that too?
> 
> Better still, could you consider running codespell over
> net/mptcp/ and fixing (the non false-positives) that it flags?
> 
> If you do repost then I think an appropriate prefix
> would be 'mctp: ' rather than 'mctp: subflow.c ',
> as this follows the pattern in git history.
> 
> And I think the target tree should be net-next.
> That is, the patch should be based on net-next and
> it should be designated in the subject.
> 
> e.g. Subject: [PATCH v2 net-next] mptcp: fix typos in comments
> 
> Lastly, please keep in mind that 24h should elapse
> before posting a new version.
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html
> 
> ...
>

Hi Shi-Sheng,

I also noticed that the email you sent and the email from SoB are not
the same, which causes checkpatch.pl to complain about the following
warning:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Shi-ShengYang fourcolor4c@gmail.com' != 'Signed-off-by: Shi-Sheng Yang james1qaz2wsx12qw@gmail.com'

total: 0 errors, 1 warning, 0 checks, 8 lines checked

Could you please address this issue in the next version as well?

Regards,
Kuan-Wei
