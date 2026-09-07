Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA0411F8D
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764766; cv=pass; b=mVprwpwUEmuLQJErifxjkiAnP8aWpXcwggzpBb8kL/bUGnNFYtkoM9aNknHYcJg3Ys9zGeMp4j8o/I8zynExKKbX4CmMAdIJht0kWACbX1JzPwM35PNdVcg28HZDUAmM+HhaOJH2J5USc3GpHHMjC1M1XnhnzAPxsE5+hEMJsQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764766; c=relaxed/simple;
	bh=J/iKiNhcMgi580dPsKQsRdnOhMrWs8rCz30Zn7cW2ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdFmQELa46ObKddIZBj9FRqg9iddVXRl4gU9/aJALx+ZlRZsqLiFDlPzwDDVtXO9KiVE0xMg7cBKOdCdd3m3r7rl6p7nMc4aEfss5H/v5YrzQkM7iCcE74KeRJgYGSf8tZcj6d9GRzNtYEXSmOjpWLN5kew0Hubzcj9rWXEAtR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7MX/vfm; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7MX/vfm"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9103f5b813aso23738136d6.3
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 00:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788764764; cv=none;
        d=google.com; s=arc-20260327;
        b=mFsk2Atm3FcffyR36g7ASQcQ1cRkYbH2VZGNnvGdh2mQrU2Z1WNxGkuO0v0j9Uvmxt
         Z/DUrqgP/Y9Qjo+GxnvryFAmzj0wZ3W1P92c95IZgJbjGQM7s62Q4Bi6nDUu4W96N1EZ
         synxweawU8DoOtmTSyNWp9qEZFXOl9BNjmGmIWlaJ5ye8Ov8x4NUFfjYLb1qEQgkIjJ3
         XlYRDyOdcxXN4TjcmVNdBkuo21P+v5xGsewgJxRHXa63Ml/Clv8TaN1/YUckF1+vHaR/
         KhJKeXdEVmp8qTVs3JVthuGrNBZ3p/WSlgqz14lOXiXOL8LZXgPn6zvxWFRxmRDPevzh
         DcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        fh=gpkfQGpwwHHpPhr0BuxW6AZg1y/qEYa9zgkXIhFCm2Q=;
        b=VOz5pv0fLEU+YL+v6hFU/cyd/4MONTdybhYBQo+7iGcKJofmop3EitH57kccnLimb5
         xLt2KEWrt2rv/GUhtSJvenkdl0s8jULNS4jzqkilI1Om4O3y4vaWZj2sRelg+ie6oLn5
         Bw7QRK714InC5ZmwG9hJQvuJcPj29RBWZtpP1WFTNBTVsYpiQxt1qqsXDBPe3r5wZYv1
         gc6O+oA//58znXxOD7d21Z4XH8sMNSd81FvtuteKj+OKwbgqkVZ2oa5NNC0zUY6FWabH
         nCZeBWUFTD2n96pRs5K1/leKpOaJnxAAGJn3X/Zy3+xwEj65LXFY4wkkpWGI8LV8R6kB
         4Jbg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788764764; x=1789369564; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        b=o7MX/vfmWpzk1UcG/cDvWftxBabLVKtcdoa9DwsnNnBMRnQaNJXdcLnclDOHNHpA1p
         3UNT70vu4SbKsE/DPDPKTiYabo29QZ1w7hLyCf+RlzlcZPwJFei8/0gEELu3TUFj9ngJ
         Z3SDrVg6/3b8c9SZywaLUCJMwz71TVENbPUeTau2l9VVaEFxgY3lyGy7pHNlnDVXOcyc
         QVkgwdohlI+v7QcAzcz8Z9q7NNEvGH9VFUcgGSe2twqjivA6zZB4rVNbFs8qVFWIU35g
         R8XBpFimIZIzqNQ7JuiRME7vDjpYZ934Abf8QSwtvaHm1SBzBqp9i9a4/j8tBjJnsQ7W
         cyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764764; x=1789369564;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IzBhMBKiowEdTe+IMHog+Eg52EGA4098JFXUESCuu4Q=;
        b=f4pOobIzK2kh57JMd78Pcf3l8WFw6xngd2YQVZXiycEUGRDOg4W7oyO8Dv6r4GWmi4
         dHDwo162ae+xLLlmXv9xTLf32BQBQ3D2bRKDsA3FJ+pLh4xQhku7Jf0RswAJRbsRP7ds
         Bn4pvbGXlKlmGuLqE9psA261WZiO+tWdrTINWD0ZdS6Pmxsn1QRpa+1XZ3I5qaKwEv87
         25ije0GLDWjr4yA64TLiWmxZ13yOlX9g5I6JuxH3ng4q/RNEfkxfejtqgCYjFW4dYZVJ
         UPuQm8VB2bEzi7QcfF/Ljb28dcC1e6aIpmG50AQYGyUbnnp2vK60RXvVUk4VmyaQeJkk
         OH6w==
X-Forwarded-Encrypted: i=1; AKwUvByA0opkvGrq/2k3iNJSLMfPF510ZWEsyHkzq3F392OqnFP71s5dwE5yE0CYcdE+wrJOOCN3UA==@lists.linux.dev
X-Gm-Message-State: AFuF++k5EjTb+iZ8mcbGRILhw9gTUE4GW9aTSI+C8YbY104FF8lTyOKs
	oGM+AG5hWmGSx8a3ICwymN64Uj62u0AID5PUi1eGLYX7yBz549vyX9ZuIIE15vKrUoZeLtAWLE+
	7ZIeNcT7zIOuOmKkkYyzeST4EkTCV6vv+glzxODob
X-Gm-Gg: AYBFou2Yj7hEKb+I+bXrtcLFvOXgpROl2eI3wCmHnM+DCTvLQB1oUNtSdw8QTgM19Qt
	6BbSvahVco4ufJM7oFj9Y47D8dMxeb8AqM93ggzBzn/XH6Adbo3FbNOtPD2ZIItBv3/WTqWrEGW
	aYzJx+kufwj/Y1ko5HlOrDCFoji7KDpKXlsWIAw3a/WDnFFPJ6SHJc31askmwItzPVAwOk9NPPP
	+XwjI5/YN1MrtT6kPTd+KFJqN669zS2YOdXPhbt44E+7MBlsJgyz9jps+Sd4I3BP6ORcTHq0DRG
	QGISuzMU2aw1cSEdZqvTHjme37YDIQ0uOuCB6c+2Oc7dEkUiqJuVdRF47qMcCIiTTs6lfBvuzau
	zw8IB4tJzwVuHIrYZgUhNS/snBrcfBUTnrt8jxZXZ6iudQI09+xYbgVNI/A==
X-Received: by 2002:a05:620a:649c:b0:937:1b8d:e3da with SMTP id
 af79cd13be357-9398053955bmr2321525285a.42.1788764762921; Mon, 07 Sep 2026
 00:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
In-Reply-To: <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:05:51 +0200
X-Gm-Features: AcwNN1WeOqUEs6cInW9RchAY2pakJxhz5cPcUgFjFoO3v5x7dYx5vG4SQCc85dA
Message-ID: <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: zihan xi <zihanx@nebusec.ai>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

> - bind cursor UAF / dangling tb2: valid
> - unconditional sock_hold() on unpublished TIME_WAIT: valid
> - clearing s_num on cursor mismatch: valid
> - lockless cursor-membership checks: valid as a concern
> - commit message overstating bind/ehash fill-under-lock: valid
> - missing note that MPTCP needs the follow-up patch: valid as a
>   backport note
> - endless re-scan of the same bucket head: not valid as a
>   guaranteed livelock; duplicate output after a rejected cursor
>   is valid

I just saw your patch today. This is absolutely insane.

Please limit the complexity of a filter to something reasonable.
Absolutely no sane user is using a very complex filter.

Same for UDP.
