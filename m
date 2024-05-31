Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BACD158DAE
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162913; cv=none; b=CvhM5cAoeSmLckp+cLGdsuNDjBJeyjOyre3Pv54i5py47lVc+Xiw8AWKEtQuen9jkrT5LTh3/OQkUEToFmE2/HkYzEP31WJ1fOBB3JPgzm7Lu2DipCbiUF4xA0xKeIL0o//TiqGKhwUSk2xTaaFnbHzI+HQdLebnWO+aiiOUptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162913; c=relaxed/simple;
	bh=czw/BKapFhZ13CUeK0JCDdbWERXp9myYt8dtbYH/92w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JS9kkHJUzhaJNL4JYp9piWeFTnAyS8VI8jbk0HF1bJD2AlS6ruDWQ4suuo9Re6cHrOqS6sOoKT1jjeEUZW1tJ670zTnh8GYFIIpYiaF/zFIsCT2ybZlaFQVIB15vCZ66+2NpETbZ/EA+eby++7I9mhH2+AE10K3XJl74BHpt0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vn+5ShNE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn+5ShNE"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d1c1f4bbf5so1245060b6e.0
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717162911; x=1717767711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hznZ5TbLrFJQo5daq/KQlDUyDPfA/APADPjZvBKy4Tg=;
        b=Vn+5ShNEj4Ic2j+9Xz1kxTr8h991Fm5tY2Kzfnb7XSuOuAs0/2cyVz0iiv800sqL+f
         l9GznmobFjN7yRC3+kMM7MQEPI0QK7KKJWU5ZkTKTrRz7M9+onC9jGYTkSf0tZvJfAdD
         1zixOXXvIT00LFwOsgN0VCDl/Nuqmxc+3DaIG85bg5KTMVb+JkOgrvTKOJW95Je4VFP3
         pcPfJ01a+txl6W6Gw/chRj33LX12eXQ6L07EmMEa5sU5RdZsgjPLP1MvCgZURnSyQMsx
         IgUFYc7m106P+OXYkqBt/U2T72eu0l3+A4QRrVhI5CXdFhLeimp6Nnkej1RfsQ+2GtWT
         stkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162911; x=1717767711;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hznZ5TbLrFJQo5daq/KQlDUyDPfA/APADPjZvBKy4Tg=;
        b=Ks6O23UaRudtuKZSjWp8g1F8l69SWdvJ1kbfCGCCPUywV9rfrHFOWkYY6AVLSDI/St
         fPhBR7pDBN2Azrpc6pAGH9Efibee5L3PlVRFZMbuHzjwd3kiVlY3HyLLyFWTAXMvH3VW
         gfh18zMkkERSrdOSsXQRocmYhqRBWP/fo+na0eedcS89vwJGgQANy36gKCaGMZ5NE4ky
         37xVnT3nIvwL25NYgaEZNdZMJ3rQwmWe5dX14ASlg42qYyLt+OQynHjit1f+cE2CtWvb
         9fNYxisyi5SUd1Oa0qRK3sLFnVwVS576T1++LNBx8uBLQqoKmacNJFb5DaU6SD6OkAEQ
         K2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUBFGU7DAQ3RmHKQ8e3iAit2jdat3UuDAJm6Rf8Fshw0hqbE1OzBUG5wFhVqoLdHj6/Xci7DJmm/u811Sv3SsdgOcQ6lA=
X-Gm-Message-State: AOJu0YyfBPppMxkqgieV9KZufl1uSzDnieSy0kMOXtWbqPzKcB0T2bcQ
	8QM3oPJKNK0TORGLTKxsso+7LVmN0LZwKRfie3cNVqIxDCe3aaEj
X-Google-Smtp-Source: AGHT+IF8+YfatNLkjgeRdgJ6qQ71ZeOY5KuN5/EdOMg8nmL8aiDsWykx1m0XRsyhGyP3JVwi6xudTw==
X-Received: by 2002:aca:1701:0:b0:3d1:c187:15d5 with SMTP id 5614622812f47-3d1e348cc10mr1730381b6e.20.1717162911148;
        Fri, 31 May 2024 06:41:51 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b416c39sm6440166d6.105.2024.05.31.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:41:50 -0700 (PDT)
Date: Fri, 31 May 2024 09:41:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 edumazet@google.com, 
 pabeni@redhat.com
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6659d39e801f0_3f8cab29451@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530233616.85897-4-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/3] net: skb: add compatibility warnings to
 skb_shift()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> According to current semantics we should never try to shift data
> between skbs which differ on decrypted or pp_recycle status.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
