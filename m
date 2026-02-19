Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D942FC004
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528947; cv=none; b=d/V7x7RpV6BsygyIrfhNB/JQntcM73zvE5F9IMkhtBs5/hA6ATNaDS5y7NH3mR7ys4w3EYWOHu0gh91zd0uWRZK2WLV5fnV9GM4FWtLqk1K35HoS4r093EQ1Zo8lMZnhf/h4Ho3CGAIOAwk0qeG16GIuxI3xYpz+miNoglpE2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528947; c=relaxed/simple;
	bh=zTbHbRlmv3uMqkzamQCDYhHdJCe6F7LjuxqgGFIwYmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Znn/p7gJy46II+a+1N9xjzfr5xvEQpnxQHKQR/Gq3/ca/5tbU3G1scZq/BccX9vui/wY7DH0NYw94qu+Y8s9i48hB8s7n/x8goe0uZwR037oCu/XH0+e1YviCWf3BW1+mYcOm+SO4zkgFKuSJ3MhLKUcBK31TGJpxIYZEIoeCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=TMs2cf+2; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TMs2cf+2"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5069ad750b7so10494461cf.2
        for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771528945; x=1772133745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmvs7ltNBb7/j6fAJ8uopBy+GNGTr1X/rFmvGsUIIOQ=;
        b=TMs2cf+2ZlRRnU8u/3mncOhXHlgGNF/obpd42Adtr/3JjChUEfy3HC9TwesybZeXMX
         t2SKsS8ulLtony/nMf8D19l3bHqyJ70rPw2jR+WfjIBaAEyggrY2E9HyydxCPbO14who
         4d3dFSJ5tqeDLzyTn0JH+b/udH7iSV9hlXIIWK35CGi/dSYe1HTto+vyb5WVAwMd+m/K
         l5kEKjeWlQSK3ZxPL7s6TMAopsX7AXGljKoF7//2+SmPN+0cWOMvZ2lAM0jz1gGJu0iz
         VP8oJhs3jHotHj2kwo+gTr1jkDibtBKenfXz7saWcTIWK9dbmJtFH6s6Hqdrz46Md/0r
         L0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771528945; x=1772133745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qmvs7ltNBb7/j6fAJ8uopBy+GNGTr1X/rFmvGsUIIOQ=;
        b=lPpUtLcixICTbJJqGEpMvlN0bJbCXISW5YVhfqlVeV3klZPoktqNDQNAx51aaThWG7
         NFOBhQxQhBB9WLxTfPEcFU+z1/MaALtHCCfIXgALR4WH8V0vYN9NlAsscQi+jVXqLD4y
         7Wqz9H6YVGk4+0P6WYN+nlOw+DZExxiC9S64t0AeWRlMWm6xCf5+HWSrjmjlHqsO0smw
         M+xZrH2La79ApN+UanPExxozwqzQDKwamQN19P5TiVyXNGJR7h1UFAjfT9n26zXzA1Kx
         0Pa9XtyvARdVuBtBSY2+Ie+HbwUV+uE7pWFUnVn9TMw8OV8d7aBswwmB6erRuyu29rhL
         FLBA==
X-Forwarded-Encrypted: i=1; AJvYcCXFXaAlQQ59mtyrAXcy7tufM9vUCKVWDpFtKNfkH2mxJFLG8WYR9n8lthBnZ2qf5d+9BSHX2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YySiSmWkEs9IB0xKilj15pCvYoAPtudsfSudbThyUYnV/qbzGTw
	IFnCS/k7tlasS4E9ylpuhTPUftJkgaVX+hn2TJtrRrPzk6dT26X4gp2Y9s8rBMk8kNA=
X-Gm-Gg: AZuq6aK2+qcLQaSAtukiSZa8JB+d07yEFdjyJy5nVnrb1LaA7WMowA0YsjS9nMHepTK
	Hk2prJTYC5D4P+yVSdG15yHOHgCMeUgR6HG/ef4oMNMtD2m0XRZRsJDxLHqj8ujG3VdF1+XAaF+
	Ei5gHljhkyI2h2nGcMcznJVi6ePv68fmM1+sxLzOA8Dp5bNIXqfCSdz6ZWoHhksTzvQAeoWfddl
	w6rLTSJ1eLRJ/61JgHhFxyxnELHyM2vyfcpmizHX8tFCWxs5msJF3z7br1JrBqqPON6/5hLfrSc
	GcTFu6RVXFLuDUEuQFMj8o3HPfauEqwxPJlq6OLqM/VnMYuVgTZ/XvwiE612IUGnYQ6mmhesMWx
	83sNG96hbbNKm+34Y6//qXHEb1gXAMXZ50P59oI5OPYqBXL9D4nDRR/IbZVwgt/LBwR1Ut3pGCj
	FpTj0ayOFUWOzfz3NbJjEe3PPGbywucutGZ7HaUOBWhQcbUKy2haDixeF/N5YfQ6lk
X-Received: by 2002:a05:622a:19a0:b0:502:9f6b:a3b3 with SMTP id d75a77b69052e-506b3fc9f96mr263994961cf.37.1771528944668;
        Thu, 19 Feb 2026 11:22:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8a5ccsm223003766d6.25.2026.02.19.11.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:22:24 -0800 (PST)
Date: Thu, 19 Feb 2026 11:22:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Message-ID: <20260219112220.6576b50d@phoenix.local>
In-Reply-To: <1f81c7c3-59ee-43ee-93f9-771015a2752c@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
	<20260211-mptcp-color-v1-1-01832777611d@kernel.org>
	<20260218103155.486d20ee@phoenix.local>
	<a44c1f27-e9f0-4f33-beda-e5f611197e35@kernel.org>
	<20260219091101.551377a9@phoenix.local>
	<1f81c7c3-59ee-43ee-93f9-771015a2752c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Feb 2026 18:38:51 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> >>> Please fix the whole function.    
> >>
> >> Doing that would likely break scripts parsing 'ip mptcp monitor' output,
> >> are you sure we should still change this output format?  
> > 
> > I doubt scripts are parsing this weird format. That is one more reason for JSON  
> 
> Not as weird as 'ss -i' format where there are even more scripts parsing
> that :)

Agreed ss is a RFM.
I did take a shot at doing JSON there (with some help from Claude), just haven't gotten back to it.
