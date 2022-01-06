Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235852C9C
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 11:46:04 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id o6so8413227edc.4
        for <mptcp@lists.linux.dev>; Thu, 06 Jan 2022 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MMEa05P1US0GsrRnHjeu7iY+E+GEp9XMb4wthcmmqeg=;
        b=ulrYYq7g55i/q9L4cWNU7Jb2RHxljiaO0V4KpbfUCg4Azc+DiW3NK/qS1hXh1y1V/A
         f8kCH25pbWSdTc+Ny2tcHIhikKOQWpaWdwTrEOuKUo1g1zwIDV+HDwQx8J85UCJiDcZh
         yCixigDFL1Yu4++F0vWgRQk91tRtKhmxd9t/XZ9OZ9Wf1pW7mKEcDfrvYf06KNy3IZFx
         fIoEZKcO6iDU+3TJu9PKSas7ZuFd2mswMqpvPLaC9mQFEGaJULX1TLwidjV/V9fA2RrZ
         vOcoU7rZaMWqBkbE7nc5JSdV5hv1bx7uhjHpkHwBqdN6kaQZkdjp8FnsWzieFwxVEyxI
         ys5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MMEa05P1US0GsrRnHjeu7iY+E+GEp9XMb4wthcmmqeg=;
        b=IYQ50z4WyfpddAcPKBUaa6zFbAsSZEVH9AJiXvBfKMhWH5FFuPS43O+f9RPzN0GaoQ
         uBRE8n4rCsZoLDfWiQnGpbq9GNH9z7RetXPxY1+p+XNNAZTZ6bnlCX4TDl5txXYvXXyz
         V64TxxlW07khf2ggvZNgYZTU2HM8mV1Tbw6g8VF7MX1jJzPPFU/JnLbHgfKVH/R+oSmR
         P0mZS5Mq3NvBRm8zIz77BqzuHqkvmidOJXNuhL2MRzfmdOpacpNRAqJw0GS7ZqYTS8dj
         LkS9z9udDFPzYZc69/i20YpOS2sdcYchMHUBFdvyP+gylUAhPFMD69Lv4JoIuUqpGCYB
         PJJQ==
X-Gm-Message-State: AOAM530FvJx0PRXROQEFiJ4Dy7vl8f7GQ1jCaJNnLho1T43FiaHimknE
	o3WiajILuBp2gJydNoD0rt10tA==
X-Google-Smtp-Source: ABdhPJyK2CvAVGIwthlC4OYWS7t2KCcPLIvQg/5jLmahkUj7+HgonYTjV3IixLP6eSPSsHCS9q+V+Q==
X-Received: by 2002:a17:907:c0f:: with SMTP id ga15mr46600302ejc.623.1641469562413;
        Thu, 06 Jan 2022 03:46:02 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f806:b935:3199:df74? ([2a02:578:8593:1200:f806:b935:3199:df74])
        by smtp.gmail.com with ESMTPSA id sd5sm438995ejc.37.2022.01.06.03.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 03:46:02 -0800 (PST)
Message-ID: <f510d202-731c-a66a-2b54-2561dc73afd4@tessares.net>
Date: Thu, 6 Jan 2022 12:46:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-net v2] mptcp: Check reclaim amount before reducing
 allocation
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, pabeni@redhat.com
Cc: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com,
 mptcp@lists.linux.dev
References: <20220106012928.158899-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220106012928.158899-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 06/01/2022 02:29, Mat Martineau wrote:
> syzbot found a page counter underflow that was triggered by MPTCP's
> reclaim code:

Thank you for the patch and the review!

Now in our tree (fix for -net):

- 73463b55be2a: mptcp: Check reclaim amount before reducing allocation
- Results: 02e9b8087979..d500488d62db (I should have split it from the
other series...)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220106T114429
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
