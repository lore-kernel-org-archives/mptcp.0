Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3E3BFE4A
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868850; cv=none; b=h61D5Q/YxsOR+dr34q8/M3/j4GPeOL5oDm5LbhIHL5MiQs39Bx9Z96Q2vofk0+OqxdxDbe+0K8zvTnpG+rJtqv2rjBwd3CNDE6laeiQUGKe4+OnxS2hgfaT2AQAC5jQkYWTDBycTdnXytuP01iDOskoR3JYyt8GrEkoiDcCVQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868850; c=relaxed/simple;
	bh=J21LH+Dp+zybi9ZNroCMtjrrLJ0ZBG03uhOHh7zzmmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5ZhUfiOwx7NFC+yp06DPTe/I6sdEZq6LOLu33k2pxLwIGaHUDFEU663Y7I5ntQpFfmXNb+Lw/30YaNvGm6pQgVLFlVdHtjf0c/EKbw+sjLVdToBmLFgzrZBV3Lum7MU2YWVcOeBmUa0aa7aoVPoiYsG8EoHL9r8SjOOo8gp8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9L/O6T0; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9L/O6T0"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so2318681a12.2
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868848; x=1777473648; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J21LH+Dp+zybi9ZNroCMtjrrLJ0ZBG03uhOHh7zzmmw=;
        b=E9L/O6T0AqORl28h1zxviTxEYJGnpKSt0UCpSeVyeTBKXFPHW/x7lhW+/tw2Bl/JzK
         MosKl6e+EApkcNMegoduOIMBfcL9ESOZM8MruZ2QT29gAmdxjuznuzYddH7b1NluIM7C
         S8qzRvSDlsUq4E6sgfA9VKmGcQ9+sJDGQ4HX0XkCxAoAzsFf9XCedAV+66nXiB1J15vh
         npnz4tgfTF45nAvvko3+U8sBeCm/UOmGp9v7Uba0QJHlWXUgSpEd0Q1TPgFXqG6ALamR
         E7NyZ1YjqukDEbwJNh5VzxJ8bu9/+dwej0KmVuFX7efzP83kPsh5FphoVyEyAjpefyKz
         iidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868848; x=1777473648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J21LH+Dp+zybi9ZNroCMtjrrLJ0ZBG03uhOHh7zzmmw=;
        b=EsKqW9JfnONXX0mKxX4Wlez5CO12sG09uxlTzl5CY8IV178n5IxPRQTCVjXTgehY+f
         0yz4kry8E3aQu8AgASkaiYe7SMQOduIwBF4OHpU/v7u7ibrUMQghzCeK41Cl2yVQxeM4
         vhA1qXD99q2By9Knmq2hqfVDpgfOcaJiQ5XqG9XJReZ2XzOVHe7uUKvjgBYPeUC8/3Zk
         TUAM6YGgUUD/PZ+GyX6Hd6EUrSrTu6x1kf4NEXhHqNFov4BMt2F6Si6d3gstUQGR934P
         PYsx/r5LvmhnSJdLBChM+EKMvkq2aqQAm3p+yVyYQOwwuKuDJJlNrEo3AeEu0fkZXyWX
         56SQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SjLEGd2+9ZiyrVAHOcum8TCfj7QUDoCXNVV50XvrdUlYvt5SNXoP6BgRAViRcNg25Ujw1oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9yTC2/hbtYLqf1R8oFS1SPCpz3I0b5JhfwXXtZCipMlDn/qE4
	zwT4njAmQkT0m7EIeUKiac7oWn0/tSiJp9jy9Eyk/OKjiqUVnM45oW6T
X-Gm-Gg: AeBDiet3mBvF5h2U3WkEW2zPnpWlTyZtd+8sVT5qaAlGynaOCtdwilA6h2ml0s55DT7
	24y6JKUK+cVIm1Km3WvkWL9V6a6oJbxoK6G1G4L3xRBmCcP++IAdibi9OQJWFGeUTxAbcvpD59Q
	ySW5mT9yCk80/sm86nEHc7SRUqJIXS+vQIZwRkC6zb6ujplGDAtH859Jn8HZmlutQwf2jumCmBs
	dybdJdyHaFbKyzP2NceGUzn5U+xytJJ7Y6SvTznI69PyJpfQjrxvlw3gBl/N4/4ZUBe9LF0A8FU
	7fCzesPRtRaXav7Rq/Plnfze7G/HF+HE9WAefF82sGJyTQz4l+uisXfY2A0/1BaEg7dngS+W48A
	TK5Yob3pdb9qTa+H6w4mINNi7641WXxs38rtChD58zJaAPHrk4Yg3HVJYpHGG5puEzBYJewGXj4
	qU/qabR8zMt1U0/fremJUm7FBONVAX6GNEyMYXcw==
X-Received: by 2002:a05:6a20:3c89:b0:3a2:d976:2210 with SMTP id adf61e73a8af0-3a2d97637dbmr12095114637.8.1776868847905;
        Wed, 22 Apr 2026 07:40:47 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f4e8sm13072359a12.1.2026.04.22.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:40:47 -0700 (PDT)
Message-ID: <dfbb7837823c2ffe0f6b1bdbfbaae71164cd7ba6.camel@gmail.com>
Subject: Re: [PATCH] mptcp: do not drop partial packets
From: Shardul Bankar <shardulsb08@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, matttbe@kernel.org, martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev,  linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com
Date: Wed, 22 Apr 2026 20:10:42 +0530
In-Reply-To: <fc2ca10a-1fa8-48f8-b140-6c59595fc08b@redhat.com>
References: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
	 <fc2ca10a-1fa8-48f8-b140-6c59595fc08b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDE1OjUxICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToKPiBP
biA0LzIyLzI2IDI6MDkgUE0sIFNoYXJkdWwgQmFua2FyIHdyb3RlOgo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgLyogUGFydGlhbCBwYWNrZXQ6IG1hcF9zZXEgPCBhY2tfc2VxIDwgZW5kX3NlcS4K
PiA+ICvCoMKgwqDCoMKgwqDCoCAqIFNraXAgdGhlIGFscmVhZHktYWNrZWQgYnl0ZXMgYW5kIGVu
cXVldWUgdGhlIG5ldyBkYXRhLgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gLcKgwqDCoMKg
wqDCoMKgTVBUQ1BfSU5DX1NUQVRTKHNvY2tfbmV0KHNrKSwgTVBUQ1BfTUlCX0RVUERBVEEpOwo+
ID4gLcKgwqDCoMKgwqDCoMKgbXB0Y3BfZHJvcChzaywgc2tiKTsKPiA+IC3CoMKgwqDCoMKgwqDC
oHJldHVybiBmYWxzZTsKPiA+ICvCoMKgwqDCoMKgwqDCoGNvcHlfbGVuID0gTVBUQ1BfU0tCX0NC
KHNrYiktPmVuZF9zZXEgLSBtc2stPmFja19zZXE7Cj4gPiArwqDCoMKgwqDCoMKgwqBNUFRDUF9T
S0JfQ0Ioc2tiKS0+b2Zmc2V0ICs9IG1zay0+YWNrX3NlcSAtCj4gPiBNUFRDUF9TS0JfQ0Ioc2ti
KS0+bWFwX3NlcTsKPiAKPiBoZXJlIE1QVENQX1NLQl9DQihza2IpLT5vZmZzZXQgaXMgYWx3YXlz
ICE9IDAgLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBtc2stPmJ5dGVzX3JlY2VpdmVkICs9IGNv
cHlfbGVuOwo+ID4gK8KgwqDCoMKgwqDCoMKgV1JJVEVfT05DRShtc2stPmFja19zZXEsIG1zay0+
YWNrX3NlcSArIGNvcHlfbGVuKTsKPiA+ICvCoMKgwqDCoMKgwqDCoHRhaWwgPSBza2JfcGVla190
YWlsKCZzay0+c2tfcmVjZWl2ZV9xdWV1ZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAodGFpbCAm
JiBtcHRjcF90cnlfY29hbGVzY2Uoc2ssIHRhaWwsIHNrYikpCj4gCj4gLi4uIHNvIG1wdGNwX3Ry
eV9jb2FsZXNjZSgpIHdpbGwgYWx3YXlzIGZhaWwuCgpUaGFua3MsIGdvb2QgY2F0Y2guIEZpeGVk
IGluIHYyLgoKUmVnYXJkcywKU2hhcmR1bAo=

