Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98123EAB7
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434573; cv=none; b=clhiRXETsqz31XktNXZk7IUmSzGr+2HeAbEcMmcDKX/uKnaLifw0+DYh9k2ByAHOtaX0kYqUa4jAt870dsESqh2YUkjvaImrIRnDSG1ITxMjxn8fQ0rraSvz3grAaYyWTBqs2k6lK6+RW84n/KNoRkeO5fGU63VKpDhGofhbBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434573; c=relaxed/simple;
	bh=ZF5CBE//uo1iUn0UcJDAyme3T9aP1Uvep0Kno8CtDHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyguHS8EVlbcuvvQhAQAVI7ko8LB1uk34c6et1zJfyk2aqITieJDoBzL4MOMoFQ37mH+bGJ3ohpoJLQ6VjlGnNyFIdI57RBSIRTGxD/hGRJg4TSx0brD050SvwNp37kWHUHMkbYGheLzshlZUC+9LfcKlMF4MQjrsRwALJq3ozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=0jrB1se7; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="0jrB1se7"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3078e0dcd67so765646eec.0
        for <mptcp@lists.linux.dev>; Thu, 25 Jun 2026 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1782434571; x=1783039371; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gFKwf36fYY31R1VACjALzX7vpz/XulsxWqVH3pAeFE=;
        b=0jrB1se7+jXThgsdhqTnyc9ZTRfFWoFIaEwE6EiMoPQ37N0+JqCsDki/nrGupVjgxe
         Y3GpJKD4jrq4TOUmw3+hZLprd08wbOQk+OKlg6yP63KzFQ7zufe27c9jI7+bWOh63O2K
         6XJdE3l1ChqrW35ztYh0SrxZvrlO0s/+kSp6N4Awl/lUrGmMMgWLuc4jSiSYMM+yC97P
         YgAOURKqDU+ejdtUjkncfXMgccINzhYfo+u1FGFzs6HvABsZky/vBKgzzLA+zyPQr9vh
         nGXn0b09qOJVK2IqYTugB9AYKdgqI7L6tam+rZ4QnZJEjSXb5Uf0mP5tkBR3c44oBJ5X
         hDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434571; x=1783039371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gFKwf36fYY31R1VACjALzX7vpz/XulsxWqVH3pAeFE=;
        b=JUIBI6Z0fDh7exEM4IcKNzmsWL9D+Zk+RLzrWnCai7RKMpCg3B98wuhKsA4FZxDqt2
         AjBMRfJROXENC80Wgh2PlSzGCku38CGI0eaFDRQmZY5mfvHOpDw3UPxZb50qVUtBUJYH
         1H5WXRg+xJGyjN4j+mputel6UUOZjq57lHYAXlPZXapQsIO9uZGY9jkDb8JXzgijr3+P
         qa+waoEiHfcumUTKWW7ZrUglEBHYtQwMfpAHyLQfuDmIdal/87MwQkkV00b/ccv5FfA6
         WTquiwiAaMULq93TUA/uaRohfPJQt2CZE190iCcHW0OljAyKfchDSIIMiNExZAFKmDZa
         KMPA==
X-Forwarded-Encrypted: i=1; AHgh+RrGMQSNrEmaIbzxKJHuvuRD6hJaFPKQfD4clfOSJHNox3tGEsoIQRG7D2m8ZlOcXFnmcKcJSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDSo4+zK7InsSOcDOCT4bNv/bd1Y/om21oOi24N58kxqBDZr5k
	MsYKCcwLcwIZVY5+y1WvFdWCOK0hJ44Znm2eMDrraW5I0qR9pjuCbKWTMTdOpSr5JuI=
X-Gm-Gg: AfdE7ck9TSkIG5/mtRHgVwBcNdtA8mw9+c2yFRZ34jiqDpIjDJ6a3Z4fx5oxyPI9juT
	wRe7Pi9VaUGcwhmYP+rnpdMYnZ8Dei3kZXqZvNg4PatacGuSHvPNqUULQrsWnW3AasJCZBv+RnR
	HUbB/P+7q+aICv5YFXaAreOGE1KCsAlordPzKN604gfe6aCwTkRYcWLUfmBuj5Uh6YNagHXLhXo
	WcOom6CVRIcYt6KEhJo8UkVcaAV0ML8Q0ObMadgBubWY6v1MevDOTvS2Z2jtSxAA+DR/WtBOC5i
	U3YbvraDfawhXRAzPtTqNoSUQmYvn8lbs06PBxfd4UXQ3x+CaBq5vU0HdUGyp8tC/4nP75j9JRK
	msa9UVmEpH0hcCNXbIm3hEmv39sb5+M10d5h0hVqD0qNFo7F0UZ4ldmTF2wDiyxV4+LTOva57+1
	AI0Bde9148xrLrBit5jO02s/DuFc9H+pdfVLbBR085Oso=
X-Received: by 2002:a05:7301:5789:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-30c84df3c57mr4058957eec.30.1782434571261;
        Thu, 25 Jun 2026 17:42:51 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c58831asm13423174eec.13.2026.06.25.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 17:42:50 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:42:49 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
Message-ID: <aj3LCUkOy6MwY7AL@pop-os.localdomain>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
 <20260622090059.5d1813dd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622090059.5d1813dd@kernel.org>

On Mon, Jun 22, 2026 at 09:00:59AM -0700, Jakub Kicinski wrote:
> On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:
> > Subject: [RFC net-next 00/17] MPTCP KTLS support
> 
> Please no. We have a ton of unfixed bugs and may have to revert some of
> the features we dropped back in. I'd prefer to avoid large new bug
> surfaces until we reach an LTS release.

Is this specifically for kTLS? Or the whole networking subsystem?

Asking because if it is the latter you probably want to announce this
new rule offically and update Documentation/process/maintainer-netdev.rst

Regards,
Cong
