Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2712C86
	for <mptcp@lists.linux.dev>; Tue,  5 Oct 2021 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633445828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rb3+E7DSf/VYsXXshKAFsDsEPG/3DWtTXBymkC4DS7c=;
	b=WDKG+T8RF5jHHxwK8acbAVkCrU9YE7p3PEqWqBt1oGI7PceOnZy0+ykbsH4QtVUjWCM3SJ
	vG8o/kiUMfsjQgh2yGNyJkuvId3rjS9O+ba8hfN0UGCEFbvHFG4zNLxXoc/HPou4mNuJ4s
	YLjX1AtNCHku4FmzUgpQv9n2U9LuXLM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-VijKeEtNOAKjRRl0vF493A-1; Tue, 05 Oct 2021 10:57:07 -0400
X-MC-Unique: VijKeEtNOAKjRRl0vF493A-1
Received: by mail-wr1-f72.google.com with SMTP id x14-20020a5d60ce000000b00160b27b5fd1so1468156wrt.5
        for <mptcp@lists.linux.dev>; Tue, 05 Oct 2021 07:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rb3+E7DSf/VYsXXshKAFsDsEPG/3DWtTXBymkC4DS7c=;
        b=C8gxYJXX/E6MW3+wg90ELSfkCB8uHuAdDn5ts1eK+MuqbSAcmzwyg+yDuXdTQIa30C
         nDq2VH+x9ORi7XecoUpD6pUlYAHD5iDPBZROkasfu1dNA3I8/jazIsJLdlHYfLL2kSS3
         RV9Pw60gy9tBXycWdDruDM6lzdO4NuoFqNXHx7XwnfxC+G4Bb1qmReGcSuqMv6oAyc8J
         fkhSvu/DolWidpyv6YA1VhzBkjVHe4q1NrKfO3aCHmKsBIGzxOeHLsknDmlxM7AplKNA
         H37Qi7R9CkvMYunyRuQX2AAE78MNf3nVj45z9IkE0GUsrkk/ptzZYYM8fHoMbtCy949F
         GEGg==
X-Gm-Message-State: AOAM531ryqxEvCwC12oVXnrYbBHsVjLu/niL1AFbhF0aaR7zcWDhYso3
	ALEhdnD3yoa0MjXrFbMin1NoAp/u39QyBC12vOvp4dbn5qjcmXjxwdpcDAeoYxEXlZ0gH1wz7Rl
	fTBiOJaEFq8kBleU=
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr4017642wma.26.1633445826036;
        Tue, 05 Oct 2021 07:57:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyru7U4Tz/YULQCy3tSHClb3yaGsz9DIDqbbgl0gKYU5SX5HbbLpP+Ez7KG+gIdwoJIXgeDeg==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr4017616wma.26.1633445825815;
        Tue, 05 Oct 2021 07:57:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-91.dyn.eolo.it. [146.241.249.91])
        by smtp.gmail.com with ESMTPSA id e15sm1514583wrr.38.2021.10.05.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 07:57:05 -0700 (PDT)
Message-ID: <766f785d4b5b86bcef6639b6e85932cda1fe6ce9.camel@redhat.com>
Subject: Re: headers update and mptcp
From: Paolo Abeni <pabeni@redhat.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	 <stephen@networkplumber.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Tue, 05 Oct 2021 16:57:04 +0200
In-Reply-To: <252e93b2-7313-fe17-45fb-f632571735c4@gmail.com>
References: <252e93b2-7313-fe17-45fb-f632571735c4@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-10-05 at 08:40 -0600, David Ahern wrote:
> FYI: Updating kernel headers breaks compile of ipmptcp in a non-trivial
> way. Seems like some headers need to be untangled.

Thank you for the head-up. Adding the mptcp devel mailing list.

I'll have a look ASAP.

Cheers,

Paolo

