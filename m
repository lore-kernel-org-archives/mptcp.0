Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2701AAD7
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902459; cv=none; b=YUIFDLZcmWRKWfjQ8yp6dTTqlNJkhpkccaaUjJibb+yS8YVZI8G4OVXsEJ+lZ8RohuXVaU14JyKB/kK7x5xqv/HJkbf65G5coYXLocCvv0rJt6wgjMsBdMuTuN36An2wDGfwT7h4oxaLjZxsq/BBq3oAGzoDGeEGCm0YvIYX9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902459; c=relaxed/simple;
	bh=ZuGe4Rt+9oEb6wq5Xr6e77k3EK8nX+hkAzoNQsF1oBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCHPAqyS1O8h0xbwUaGtUXO2d16RWCCPlQ3v0i1F9P+XaCibUuhx/RjhQx+Kkh//mo9jP/HnmFpauQtGIoYUzY8o9XsOE31MOvTX9FvHEsKIZeOjKem3F/tGO4lAQ2T1X/DtaVVur5JzuiXRRa55Z2B8bWZSS3oTe9cJVZ4kh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOZY+INh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOZY+INh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so15053a12.0
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 04:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709902456; x=1710507256; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuGe4Rt+9oEb6wq5Xr6e77k3EK8nX+hkAzoNQsF1oBo=;
        b=IOZY+INh9gSgJkaOVYxR+Ee1ZguWs8j3yEufoGseNr9R5L3AT/dsGKVm1NA/DYZd0d
         TItWMGOOVpRKof8HrwC0/Jxw5CzOu7+eVReMjTRTkNodajP0jjnXvLfpnNQB/lSJ8NRy
         cS0dvKhyS8TVAgX7DxfvpxXkJ/fW3kGbcKcocvGjoMC0/XDvGV+48NVJ4Nt2CRJla7Ww
         emyoY8ks5tpOHkq5Ywoj9KvkgmpmxCzy/Fc6zerKeeoU/1AykthozOP6tO1BGAWOwZSE
         F1HX5rVKB3QpjMtE9I5ZZ0xlz0ouKo7vJHbGQsq9/Q4il/2YbLVo5+5R0jT9+be06c71
         931w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709902456; x=1710507256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuGe4Rt+9oEb6wq5Xr6e77k3EK8nX+hkAzoNQsF1oBo=;
        b=sgBw05v7rIDsSZ241SY5ZOpCKcVEzcPUjlDeM/gTVqrd8ziKYbHgEI90ufNTiRp9tv
         Fyl5/jQsdVQwqH5N6e7TEYCYURvfm2lA/HvFPCuUZQuAkeT7uSiz/t1Him6dSw7WoawY
         3qlS+UP69mRjnV5uQhEyTv00bAwhO13YDJ81266ppHjrm6USLNWfbhql8ah/0Ci5K8Iy
         U9cq4VknqIeHuXHuMyKBjoDG6jnaxE1L6IZ6JSIBZ23r19ihOgm1iaVjc9X+CSYrML0S
         5bh+wLuQY7sK2mDZg7tYx2FPq6FVLjjtvYfTzjj5OjtftwA4lLOWaXdpP+oyQeWlnHAJ
         FtTA==
X-Forwarded-Encrypted: i=1; AJvYcCV6IrXnoj95SwFnAImHtFO1R/gRJt/Xu0FM3aBK6E+NCa5ln/brjgN7iyBmcMRSkCvv/9+GZd3dRe34fDe5VC0qlGIkUcI=
X-Gm-Message-State: AOJu0Yx+UlX7HrkhepuYVGWtlGAv/9EwznO/2CiCrx34bzHYrl8j3XgI
	yklJm2C+q9LD21IHHmVQkEuRyCQYfIy8yCAjmG9U1/PwNM/SsjFn0Ffcn1qbGGvwU85jdGOycZT
	NndFvc3mgQAqJtdlhi9wpEKjrS+ApIwYZ0D53
X-Google-Smtp-Source: AGHT+IEGml08pvLJ9T6mUK843g5WD7xcNWqyrsy/AFWQwhrshtjB2SW+NypVQWf+EBk0jLN3uLwh2XmPqVlgzP3RZh8=
X-Received: by 2002:a05:6402:349:b0:568:257a:482f with SMTP id
 r9-20020a056402034900b00568257a482fmr225313edw.3.1709902456150; Fri, 08 Mar
 2024 04:54:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240308112504.29099-1-kerneljasonxing@gmail.com> <20240308112504.29099-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240308112504.29099-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 13:54:05 +0100
Message-ID: <CANn89iLaD95hfe90EAkkKadxhDGniT4q5tf2Let7kTHYSm2gqA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: annotate a data-race around sysctl_tcp_wmem[0]
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> It's possible that writer and the reader can manipulate the same
> sysctl knob concurrently. Using READ_ONCE() to prevent reading
> an old value.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
