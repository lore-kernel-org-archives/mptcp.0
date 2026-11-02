Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578609;
	b=2U+09IuVjZM05/zb+d2o7Ktzsh12Q79TZww6xvsg09ZO9y0VfpMBNLKOiQhgHLg3zCXB
	 PD687Zlkas/TyOQYhku2wqeWmxVSfEaBPvK8x67PfInJ+ERAC8Yw9eX94J+o1jM6np2Nh
	 ZgyxAS8UHasPAE8aGAJUCxZJ+FPWvpzKtRrhAnYMIJHTJvEiH3dIijJCi5g6SnwsC+hDD
	 PVXrVQ/K3Q6pq7U91B+U5RktinOxaJrGnmviELenQ7AjMlxYB5L/dNopNC906xy2NJmQ0
	 5D+V5k9TLkiwpzoexsWDd+7S1KO6fePl5+71bBGAxPTHA/+CZ53Tfk1Zcdtvi6+oZdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mozC9xUwsBeOwQ4lriF7JYk3bRm59v0HIYqRgo2OnDk=;
	b=rE04I7whGCU374B38J4w9AXytXaMjsAu8DaiOfFIsA0m8p9OKlSXgdAtesB0gvADpx5Q
	 GjiY4s5ZKoZzpdmAYbU1BttePD60jYtR4pVk+Ix+7QS54Hms2NfE70XaBZOapg8O4C4XF
	 znYO0+Qf7dZqVTUBWRvw3vfzzgd+Igdb4YyOg4Vig3gMfS+7B4yBFF4x2m7QPsKH2z6+U
	 JGlY/wQo609j/2G3oHiWSbJMhyxRooY5PrNpDMynWxg+6dEbWH6bYgtoc3TvHJVmgcZn2
	 CxyPcyKeK1DREfOZgJvjWKKQ5KEMhv5hTDZj68eXoWsPw9VFNhnMj3RTWc+J5eV7bQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bivwVBUs;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0D606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 00:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02F0D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bivwVBUs
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so725263a12.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578608; x=1794183408; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mozC9xUwsBeOwQ4lriF7JYk3bRm59v0HIYqRgo2OnDk=;
        b=bivwVBUsr/FAtKBQ8Oltopc7iZ4JTYu/Mx/6mlP/+JrDW2g9YFcXVzKbiyxdS+Aclz
         u2RbFjs+cjnwq02XUSgIzCEET5O6eRUm4LLMvjBAQkWuNasIDLY2XipkfbSMhY3B2AwJ
         Guq+BQyALIJjEhP2R44+REEikmpvjlyJOXmUtUhRg/Ugnytp3sagacxi+0H5jtdbU+9F
         /ik1S5vzr6faaCJNUDV4xmYHJO/NqhmACfgE5bjczZoSECirURCWDTvHXkxbxxRrvpIE
         3WrlsDspjXgk83eUW7ai+E01jm7srCVzWtejmhruNoLcVoIYXKKHU19/0mkenpScMkBS
         pusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578608; x=1794183408;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mozC9xUwsBeOwQ4lriF7JYk3bRm59v0HIYqRgo2OnDk=;
        b=XALpDJv0gA57YckNQvlT5evs0sWT5nLLzShuPmxAzL7t8y8tyeTb7W2Ci6C/wlpxTX
         zuMbJOPXaMOzsv/dfF0u3s92sYgdBfS3UDMhiev3mapqiZqQKAo2d55cVJ6VvKo2mvZ5
         2IJrJ2InZ9qXACcCa/CqI3J8jT0wrOc52k9vFC2s4dDxUPIRaZfbffYYv/Ri7pwVZbQH
         iZUatrZnKfX7+1yK3x1/YjPzZIV2BgKwo28iQo75fcDQn4LCubyJpiTs3dV7s9/drXLq
         oSka0ZaLTKur62Eqq/DtqH1YLsTVVLIV7tH5RlGfWYKQe+1fiAakSokX3z1JdupnvPgJ
         l/1g==
X-Gm-Message-State: APuU4Z+dlGKuK8j3nq+i8rlEwdzpgrNWvvVmF9gHtciCMS8cbN9nI0xK
	XjnQsRufZX0Kewk18Pa0b1xh1md0EO3hucbwRG29ZW5JjqdIm4XcVavF
X-Gm-Gg: AYBFou0EHoDHyYNOL3TtvkhB8C4YxV6Tk3REKQwTMHkx/F7uJw66Ac5yqAYXdRYr+6h
	mRLzN46PLXI4VnIO9qsDTmnyQ9rwwKqoRc4QMORcmsYbkb0I6vVeKB4kGpGv9QZngR3se/E1qMX
	+rMMjicY5urvp8cUf0VK64C9gI57Pinq/J7U0uqFrfQLC11Hyhmi7aAhfbmjho+DWJLl+7qIo2z
	Xg1z/wz19zsuh4k48t7XI8ykun5Aze8j4yd0c1EfTu2CAqm7buh8gJ7H3pz/AJxHoziWp9w1wei
	S+52feb+3FzJENVl3rl10cLA4a1Yf4b4DXipifc2q8EMFfm3RW5Ey3RvvsB8n61zVLpAcjn8GgQ
	zs0WSviKfnNKgJ/uZ4TE1Ki9MdUUJLBkvkT7J3fNCd7txZHC6ZCunlRA4jRC7Y/8iEaFSvZ9mt2
	fif431pthTm6Rooz3w2pdHu/xvTLmZbDE6U8vrPOFL3lfdF/V2nDIuGawiH0R+td1k4azx7m9Sl
	15qiP24Rv/h+8M19ADJgHrO4sVx9T0VxR/fOghDRPyyIhoCEyZ9f/pRt3b2lXfZN9LyT4UpClwC
	hLAMvx0qSw+OMovq3XQoCwAqBVdDL/rS8fhHrVHcTsqw3+PRJYzix1qXChRTdhQ9NX4QrjIeQEg
	Fz7oSVa0BIJn2aPaq7Rf0Drp6FsqGUVTvFI0=
X-Received: by 2002:a17:90a:e70c:b0:3ad:a232:4044 with SMTP id 98e67ed59e1d1-3ae8979969fmr6431543a91.38.1793578608316;
        Sun, 01 Nov 2026 16:16:48 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f3e087sm6950889a91.1.2026.11.01.16.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:16:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:16:47 +0000
Message-Id: <DMKAJXEISH7G.1I34WXM92FRMI@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Cc: <mptcp@lists.linux.dev>
Subject: Re: [PATCH bpf 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <sashiko-outbox-192629@kernel.org>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com> <20261101192057.2296489-4-alexei.starovoitov@gmail.com> <sashiko-outbox-192629@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 11:42 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>>  		if (unlikely(ret)) {
>> +			/* A part of it may have gone out */
>> +			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>>  			*copied -= sk_msg_free(sk, msg);
>>  			break;
>>  		}
>
> Wouldn't Thread A subtract its own sent bytes from Thread B's
> psock->apply_bytes, and if psock->apply_bytes is 0 when ret == 0, reset
> Thread B's psock->eval to __SK_NONE and drop Thread B's psock->sk_redir?

Not a bug. eval, apply_bytes and sk_redir belong to the socket, not to
a thread. B's verdict ends early and the prog runs again for the rest.
B sends with its own reference to sk_redir.
