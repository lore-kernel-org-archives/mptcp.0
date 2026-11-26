Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706974;
	b=vLxMB2tNpKqyATPfT7Xnii/oWI9RV8PfO5XYs6TO2ftJ4jGNsEW2zbYZnwfQu4w+n0Rc
	 vPe0lTck82YT+hilmu/wJvPslTkxc70KA0cPMALFhmHxl7netXKEWVgCyGz7wxir57d7f
	 7EUpSB8lpmilBBAYYbICIPmZ3WRtrFxlhfF9ENnU1CV7JD7wG2qySsACcT9alG/4FrsvO
	 YkslHOf3/OI/UB8jgAGsMAjJoLuFWiKM/twUk6nQLGbQqBEz0SFX7s91FXvbAhWnFURXw
	 9b9CBifnZT448dojF1sGjCHT9ywgUuR9AUPJvaRKdyPvhe+IH6ZrfT7iolFo3g0PKLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TqDA52TiA5EZGrLT5jnVgiF67AGoOi+mrlY8anEiueo=;
	b=UOXkP6C81piHHE9sOc4Y/L/Yy1xUGXOGkwG7hRrTe0Ax2TzSh11r3wYObO92OiaIWmjU
	 yjOvnmUP9Tc12ooLm5EDUhkCaegvUG6uEUIYyMeFeNc561yU8jKAzJj3AyvaqGhDgApU0
	 mGukGe0D7DvjBq7hHvUaP+2/ywCTShXTJVe8Tmuwr6eCCYoIo5HJ9d9n5UNCHk1nLgY/0
	 BxBtqHqzHorPF7rBpHSZoa5wBhB02qoQZithO5dJvt47pIVenZ8P618eME4h3cfcbz+oa
	 ivKBZImsyvdUSkW2R2ZJDvPGHTGhyZXt9Gahkqzi6ZbdLQoMags1QtkmuPE6aB9jWwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jdo8VPQ3;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AD606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B2AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jdo8VPQ3
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385d8a00598so10473107eec.1
        for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795706973; x=1796311773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TqDA52TiA5EZGrLT5jnVgiF67AGoOi+mrlY8anEiueo=;
        b=Jdo8VPQ3JlLTD3RPei/Vc8qI7p3wpKV03tHXjwoU6zUH3YT2Wlp7JJJoWeJl9UhKiB
         9AKThgayWekRtYK01hhUfovZwo+MGfAcKQ8/gnKlRSzFOBwDNFatraYf9PpNHfYWi2rt
         uPMl+qTWB89zdEs6YV5+q2JZcVX8gGqaSCcHbId1WAtsPqAhWP02yB94TyYp38Yh0gdf
         lMNgPNLb0DyIHKMt2RwzSB1tsn/IEbKCO0iduZPlSGIKWQsYoVewv7wwYJYiDk6iv36I
         +gjfAqrmREEQyzQYBMIdDF663UHPSm8hsoMye45zzFjiKO6aznKZMva4fA+7HX07atzY
         RrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706973; x=1796311773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqDA52TiA5EZGrLT5jnVgiF67AGoOi+mrlY8anEiueo=;
        b=iFg03Zsv8veF8x8KePcss1dnzymrBJSccao4VZ/ZD5kCMLMlgIIoS8gbLaeqebr46n
         53p4DnsesCpt1B6vSeaMkpoGmcpjlVIBSwUPNNosz/25sNJvpz6l6PPMa3E7KrWoZvyi
         y0clOelBrFlNEasUHsQR7s2qY2uCC6c+VYQAiW+mV07IvilifKQKClVT7BAdhzENcrua
         GYk35RySt4OshnIOGL331OtJ/AwwMxHREDIRyj3/wprC68TBE3oP/6riBseTSYH5G5LB
         WlVQ9jfmpDp8jHi4KxplnrpyK8FFEfATDYj/dyii5D8VsYFH+dUnGGHApi7kn9a6OJPz
         uY1A==
X-Gm-Message-State: APuU4Z+gycH1Ejtjh+RBDcDyBpselWsFXfoBOhlpSSJVRi6Zi71dtiJd
	zwHqe7v3klZyIS3B/4H73OGT6WJjmYIeDZCKCDc1kRdahA+KAm5H0Kxd
X-Gm-Gg: AZFdTZeJmJq4x+iUigSNsKbMpJwX8KhfjpBSk276tiBKySFY7nkvC8+DbKwVhDBTYSV
	lF371xA1GK8uLoJuW9TfBR8jVtx6u7NvvOdF3GfZJhbAroOSSE+7EBarNp/QATxAE94KhaddJ36
	oP2ywcBF1MHK1Kos86aj6GdaZbUNYP/zIB0/zvYyJQi/t3BorWS8zUDcsgC15Qdi+2w4HJTQ5z5
	qEJNcYypa4dKSLw43k+XnpqTO5fmam0/gME3NAFmJZD6sEIVLe7Fpfyp+RFQMbTHWDlATh97iMR
	UGJS7alOa+fabKxybP4679U1K8DD7kwR/IEqlWZiJkyvZTrSoYp9cDbLM/23Ji+xR27QyfIBg9X
	wtCKLSi7eaIu1sZtyqN65DpUs0jd2cIRKgfgGZoZ0nlFZHy9YMNxAHDmuyD/DbCKn5XNV7rcgpm
	vgnIRw23Fxr4Unw7qNgioETfCsAz0nYGxMQLv3AqWXuk4vGrmdPLiuOgMyX3l8qz62sdiNpczlr
	6g3OvK0fqRHlfcCLc/aGAjuKMVaCLtopjr/CRK62LrPTJrAsBlDvNgDtW9NrZgxBJwBtbgTMv30
	FZuvhCxq8RBfLpV1hQ0RwsdFRBkCiHLrALs=
X-Received: by 2002:a05:7301:e0c8:b0:386:c724:cc68 with SMTP id 5a478bee46e88-386c724ceb2mr7058487eec.2.1795706973233;
        Thu, 26 Nov 2026 07:29:33 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm77580388eec.4.2026.11.26.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:29:32 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	gang.yan@linux.dev
Cc: mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	stable@vger.kernel.org
Subject: Re: [PATCH mptcp-net v9 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Thu, 26 Nov 2026 15:29:27 +0000
Message-ID: <20261126152927.3924317-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c9eb1633-ea90-4b86-b7d5-dc3c7ba2bf1d@kernel.org>
References: <20261126101818.3916631-1-w453y.me@gmail.com> <20261126101818.3916631-2-w453y.me@gmail.com> <0f1d9633b78cdacd57f4c235a5a787426083d788@linux.dev> <c9eb1633-ea90-4b86-b7d5-dc3c7ba2bf1d@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang, Matthieu,

Thank you both for the review!

On 26/11/2026 16:09, Matthieu Baerts wrote:
> On 26/11/2026 16:01, gang.yan@linux.dev wrote:
>>> +/* Closed subflows can stay in the conn_list, e.g. the initial one: their
>>> + * addresses and IDs are not reliable, possibly even reset.
>>> + */
>>
>> What about dropping this comment here?
>
> +1

Sure, I will drop it in v10.

>>> + /* The initial subflow can be closed: like fill_remote_addr(), use the
>>> + * remote address of the MPTCP socket for the remote ID 0.
>>> + */
>
> While at it, you can short this comment to something like:
>
>  /* If the initial subflow is closed, use fill_remote_addr */

OK, will do.

>> Another question, why don't you just use 'full_remote_addr' here, like:
>> '''
>>   if (!test_bit(0, unavail_id) && i < addrs_size &&
>>             msk->pm.extra_subflows < limit_extra_subflows)
>>         i += fill_remote_addr(msk, local, &addrs[i]);
>> '''
>>
>> It hasn't been tested, just wondering if there is a specific reason to keep
>> the duplication here, as I would rather reuse the existing code.
>
> Good idea to try this!

No specific reason, I just didn't think of calling it from there.
fill_remote_addr() already checks remote_deny_join_id0 and the address
family, increments extra_subflows, and returns the address with ID 0, so
it does the same thing. I will use it in v10, and run the tests again
with it, with and without the fix.

I will wait for the netdev review of v9 before sending v10.

Thanks,
Abdul Wasey
