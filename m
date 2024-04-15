Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F023D3BF
	for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174224; cv=none; b=XakT0TnS+q94WYW6Hja+YltvKwhLhx+VeEPIwT6XYD3+x1YSIyQaUTxXlblT92NnFw/ZGmIBJ9Eyap4RoPFEYXSd6XNjL5PSRVoi1q9zXNhfeuqZzzd0SAQ5XTXvKcBAQyLksm0pR54H59+qrSn9yXu0tjVYZ0FbwLV4D6MmdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174224; c=relaxed/simple;
	bh=4Pwqr6qkpimMrDhPbnteVeu9Mxkxlzhny0T9iLGCfaU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avEeF8zamGTIqi1ACojx0Zw4DnnFp6wjoQ4xQVGaVMiBS3SEy9f7IHaNzWqU8SzPpIMsa1JYyN9zdrIFdaOwdSfdrAiCdqiGeQWuha8V+DQNd2C3t9dZ9HLvHw7OfNJpP9XQvv+0BbBckz0BGvkjj351PLxwMOzWYH5/XyMaBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPPpfkyV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPPpfkyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713174221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Pwqr6qkpimMrDhPbnteVeu9Mxkxlzhny0T9iLGCfaU=;
	b=VPPpfkyViDJkESsCDXts9Z2Lj0BTpOwkWyQOZJRwndXJRbzgrYbXGDGAs3QsTMJmkqiCx/
	pgj+ZK0n/WLq7fLckIlG/cknRr/YV0gsYRbI1mUwfcc2H6hEbvpx4kcdQowzCAA5uDq2SA
	tdMPmLuzRbpmv7beNlXrcFdFZsHJSFg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-1xR0ZxARNmuGNelXGbs_Fg-1; Mon, 15 Apr 2024 05:43:39 -0400
X-MC-Unique: 1xR0ZxARNmuGNelXGbs_Fg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343edd4ac01so689004f8f.0
        for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 02:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713174218; x=1713779018;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pwqr6qkpimMrDhPbnteVeu9Mxkxlzhny0T9iLGCfaU=;
        b=krJ+rcaeuVNfoLi8ziycr2qUXO2kC9Cdf67SX3lTZ5eA5ur9/PNOSZZbsfLh8g3lZZ
         z5iei8RSAXD4SOuAolQEs+WC93wzJTJxY+VvJE0ynv+bE3TllEK0n5xgtpcr6QztmYiz
         xNFXUP+wcddJLPu2Js5sjM5IsalhLcOZIDAisRbvNqaMwLOrMJ6HAvgNByCiizvRN0YO
         QtM9tWWauxyXpCASKfqHaXzTc7V6EZXSroI5TOW1H2bTRKDDoLZoS3kzWvmtA6Esd8xs
         wMsmRsTELYrYgDZu4a5IdnSU4wS6pHkiKD+cGJE5bsPyhHlgopk7VVDcgztYLvKK18UA
         WQOg==
X-Gm-Message-State: AOJu0Yxz3tNYT42NXM5fp9iXVZBkt/+vYMA3oQtvw8w+NvfPV29NTQZ+
	Js6oa9o4GXhseZtZB4OaLOGeZ8siEZC0KehS6SKfDEmYKGuejV57hrARlfVOz97y2TTxtiiQ4xX
	mDzfmOCse+0QLSyMnz+uTX2u2VRQZ0wNARM5jIcYKIVDE8Yj2bwtBoQEokhOb7Oi4XeSkWFlZ9D
	iKrsNXGETw7NZVbCQoVMcGuIiWyyOBwWoBEQ==
X-Received: by 2002:a05:600c:3556:b0:418:3cf7:7f7b with SMTP id i22-20020a05600c355600b004183cf77f7bmr2978455wmq.3.1713174218548;
        Mon, 15 Apr 2024 02:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuf044TjLX6i0zYi4xFggg+M9YD6Y24dfAyzPUEErMTMCGa39MyTHWC5lKzeHMVphN42qWiw==
X-Received: by 2002:a05:600c:3556:b0:418:3cf7:7f7b with SMTP id i22-20020a05600c355600b004183cf77f7bmr2978439wmq.3.1713174218118;
        Mon, 15 Apr 2024 02:43:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-238.dyn.eolo.it. [146.241.228.238])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b004165315d885sm18732581wms.11.2024.04.15.02.43.37
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 02:43:37 -0700 (PDT)
Message-ID: <50dfe8c04cc26c24023dcc0b1c126c415e61574e.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure snd_una is properly initialized
 on connect
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 15 Apr 2024 11:43:36 +0200
In-Reply-To: <57f7b390-dfb2-cf9e-7ac6-62e279082d91@gmail.com>
References: <2b6d11d0210f683cc0de8bb47a923d568cfa8f47.1712942966.git.pabeni@redhat.com>
	 <57f7b390-dfb2-cf9e-7ac6-62e279082d91@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-04-12 at 18:22 +0000, MPTCP CI wrote:
> Hi Paolo,
>=20
> Thank you for your modifications, that's great!
>=20
> Our CI did some validations and here is its report:
>=20
> - KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_sockopt=
s =F0=9F=94=B4
> - KVM Validation: debug: Success! =E2=9C=85
> - KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8665=
962144

FWIW, this failure looks unrelated to the match (more to the
troublesome pktdrill aggregation handling).

/P

