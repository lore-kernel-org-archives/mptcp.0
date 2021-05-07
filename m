Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7E72
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 17:45:31 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id s7so6476062edq.12
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bLEjt3sGsKagc8B1Onucr1q12Z8iy4MZy85l7noGtd4=;
        b=invoYbTUXZDrUsVnbabaAVNJtUl+hXA92MwGf2jbTy9/y5gKyhctAytNm9kw52LxV+
         zqqxIKMZffK/9br29lHItH7AEgzA7m8yH+9EiTbrmOUnFAboDRgfczULRtLF0Za26NhM
         YvG0ytdbHzPeV985kwP5wC047iuZX5OB+3zbFhQB3N9geEwH7oKcVebwK/Dt1BCNDiU4
         kDhS/nL2ehP9kDF1c+JTSubsSv6Arit5m+X+tWxYLn9prVgqTUEoSKA+t977ZJXNgMAI
         HddH2bS5iH14fEOJoqZQwgXK9hXx28wrN/j7AvK+h3ek/Fv/5LGr7BxHK7ncJSTRiy9B
         qgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLEjt3sGsKagc8B1Onucr1q12Z8iy4MZy85l7noGtd4=;
        b=mGA0DY9NuimsaJv3MaxmZX2K+mLKJWQvBpr77iIraxeXefW0eMaRLjnoU+OxOrhirY
         DabbBTx33bfupnJVxoGVZWsc2FntKKAqiXFwbpGSYJx6FH+8fTGvMUexlvWFbIa2qOCt
         4lHFzhwrraCWQB9T5TLEHcMEUrWVwzfJ2NFgsSEHfLS+hFe1kjUS3XsWw2T2y7EEpe8+
         G68oCjB9DLEmue0zho9Y808HawRk6OhAL6Dhc2T3yoJuiI6XmBoAdCvZK9X8teek2U8v
         lgO0q//9wdVOgo7KYiP4vWwiaRghq1wM64wM6pdXjCzY2GoVJ4CdMcl74U4NNYcl6qpH
         w2EQ==
X-Gm-Message-State: AOAM532nKft1DnISIcrhihWRfnaXKnG7WPGoEMv2DOj+LGbZPgr10CEI
	nrWeP/vKVvhkY36+9w8tBP/HWyRSL+viuDXCWv8=
X-Google-Smtp-Source: ABdhPJwqvykFOBZ2JrXWYSJZvexsLUxnUIcz6+g9NjkLE8QUbVUJu4DCCtwhHfHuYoLdJtPLiGLSmw==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr12485782eds.109.1620409529710;
        Fri, 07 May 2021 10:45:29 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2fa9:2d27:234d:525d])
        by smtp.gmail.com with ESMTPSA id p14sm4541685eds.28.2021.05.07.10.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 10:45:29 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: avoid OOB access in setsockopt()
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
 mptcp@lists.linux.dev
References: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
 <a73a8ce9-bf15-a94d-e936-444632eaa7dc@tessares.net>
 <985e6bfb-c31b-47f8-b94-3eef631578e0@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <fde1191e-9e7b-a83a-d968-a24fe5467cc7@tessares.net>
Date: Fri, 7 May 2021 19:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <985e6bfb-c31b-47f8-b94-3eef631578e0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Mat,

On 07/05/2021 18:45, Mat Martineau wrote:
> I ran syzkaller for a while and didn't see this crash (but without a
> reproducer I don't know how definitive that is.)

Thank you for having started the tests!

I think Christoph said he quickly got the warning after having
re-started syzkaller yesterday at the beginning of the meeting.

Do you see the same issue without the patch?

But I guess we can be quite confident here that the bug is fixed :)

> You can add my tag:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Done!

- 983511e46a4f: tg:msg: add Mat's RvB tag
- Results: d76b60f54174..860b49961672

Now available in the export branch and export/20210507T174457 tag

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
