Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C93D0D1
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754268; cv=none; b=AHZSzhDXYFCVsJVfkTEg4qzF+ce42uw8IMrD3pps/XEAoc3H1L+JQq36Tz7V4wkj7tDEsSSk8HZXhizpy3fni5IgbEGOT3HShDaFlgdOsIokl4VzdSYx7VvQ7pUdr0JzY5X7Is50SJfitXZIOfdBKUmGA+nCIxoiVW1iVvPBmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754268; c=relaxed/simple;
	bh=yasHagw0H1ASoiPBzSSvI7VU5wX9UsELds/ajnABK3c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AfEi1JeZ75t+8k5Nx+V7b9qnx6Hy6txGzKC4W7pgxeObcQhWJC+VnkqaSS8rIMWZf0E5YOcm9TltfSkzH4Rre3NFAO+C+goOGHgAztn1bQbI5xOfFY4ZYXbvO/jUu/Fl7Fa/av5wOte1Bf9pQi0D2FefrwoYpgGHCxsYBEnTqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZQzYz9o; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZQzYz9o"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68c2f4c3282so16365686d6.3
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707754265; x=1708359065; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dASvIw5kRsdLkp17HLrum1JSJ/YRJiNMRd2GIB8rJMo=;
        b=XZQzYz9oX/JGak/kvlglc6jt9dB6E8P4qlXK2//IVqfHZNM1mRiHpPM0ETA2eHkzom
         UN64EwAY4Ap0A1j9zmSLSo0JM1dcWjcLJXI5DUwHe8L37GFQ0GaaNTlmpoDngDYsFCr5
         0KD1896gu39LJW7qBiJRPnSzzHYZeq9k7eKrmcE3CkChm48+Y3piIOyJDR4LH9z1aDlZ
         gX/TbXVzXH0j2wwBu24aaQfvDIrZY2R0J7Z00jk+z+4utR8wTTLj7hjJ09hF04BG62aV
         wvxGX9Ke9Akn0oXVh23VirXkuQbShnqcvewuiVnYFRwvIAwkJXWt2JMw/9/j/HClPPSb
         KGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754265; x=1708359065;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dASvIw5kRsdLkp17HLrum1JSJ/YRJiNMRd2GIB8rJMo=;
        b=Xu1yRxE/FPJUaMmgLAExWq1CzHGJ6IE47X2rNaNki6g9lB8xKR7LmS/fYqkhzAInhk
         NQp7ntloEn2Qex2/gmB5v/DcYyKM44KgILGUlDqyUhJpJBuBaEFy7/9TT/CDNOvNGN3S
         qRtl1polXwBUkkFGujaqmqMrwLF8w9ZiY6iazZ4l9aHAj3qSwG02uL3BJIYbDzbaYV9B
         kb1EKqV3O4bnDDcFWht3fmgpEoaNhRzPd7bsRcabx4urHtzxKD218+1MtUQTsWKxIory
         vPCSOsS/KVZjW16ld4QJl9pJUg6lBVqi67uVZb83JSqYbPTxeXO//KHHBMyenbDBB4Mf
         RwtA==
X-Gm-Message-State: AOJu0YzWBz9JPc6KiKVfw70cJGQfvBtJBQkwPI4DOa/tqAhzhQcbzHU8
	4LduACUBNl8K2g1o8wi/w9GizitDmrx1VLwpkPTlKFVk+PFJX6w=
X-Google-Smtp-Source: AGHT+IFYOqgFoD9Lj+F/9z4j+M8zI9BTIEUkAmRUVcp7LK05rZUQ8rj6TrgId0dU+jdJUBuisgYT/g==
X-Received: by 2002:a0c:d983:0:b0:68c:96b9:c651 with SMTP id y3-20020a0cd983000000b0068c96b9c651mr6538653qvj.47.1707754265608;
        Mon, 12 Feb 2024 08:11:05 -0800 (PST)
Received: from [127.0.0.1] ([20.84.127.21])
        by smtp.gmail.com with ESMTPSA id oj11-20020a056214440b00b0068c71b78980sm281601qvb.118.2024.02.12.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:10:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <da768759d9993dc8b086a1ea40131be592ae55ec.1707739536.git.pabeni@redhat.com>
References:
 <da768759d9993dc8b086a1ea40131be592ae55ec.1707739536.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup SOL_TCP handling: Tests Results
Message-ID: <dec6b4c2-acc4-0713-00d9-a7960f8a6337@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 16:10:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7874079031

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/11a409accb04


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
