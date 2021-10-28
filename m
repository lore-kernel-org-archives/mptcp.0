Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9072
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 10:12:05 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 5so22015394edw.7
        for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nKi2DpdZmCWkX9HM3C1tqv2L8uAnnVSV85/6XCx28w4=;
        b=rDU3ueKf51nT+K8hWwfZISbM11byXfPp8z3M6IubGXinfEp75OcmzOo5Xz0k8AVZre
         jY0Glw6ejW/vtV9D6c8oEdkfF/jcP4Wp1MoEjEXGICJj6olqQIw4mXgt5zb/9B5SGwB5
         T+ogDKIcqhpEZ2fs5Gt3tJEx2NHv6Cs0AbdLSUBnt/GbGC7emYw6iTsYyaFY+YTW1UrH
         M2nci0P3sN6AOIABIOk9riPBXCY9UF3Enw/37LrZ5Jikr5mZHxajpWRgCg2LggMtEyCb
         emDrRQ0wugik05cIJ1QqfCgXGXB2AX14aw91fj+JxmzJKK1AAg58ts5W3tKBDLWuTc+T
         dDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nKi2DpdZmCWkX9HM3C1tqv2L8uAnnVSV85/6XCx28w4=;
        b=XsJIiCjRWfEa4WSh9SMXzFKybu0wun9ey0P6jnWa2PZHyqcp0KD1ftEeRWSmm8q9bL
         U3FpNHblxkuzhhX3KfoiNa427WpImh2w3FPwVi3+Z3knJO22Zg0KI9RwXv/EwFGljh2E
         CpMP9FO3v1VVVOtzEXytp5Y2V7DwWqpZr0o2FVOpniZPSZkh3X/hUK06yyrGHnqmJ38C
         TAEiKSoqw+Lsvwreh1TuXXPKf2fzZQPn5gDlwoQ4ttJ0FKv0mXz4cxn4g3O1gfiAin2V
         nyuTz2GIkGaL+v9a4lwWQRZzItUC1qQKBLFmRbQbhy6Hfnz1OoJlhJbGUmAFlgraI8no
         5/Sg==
X-Gm-Message-State: AOAM533cjlIr+Sc3OQAKG0hLkJGLXR0/gcC+rCyP2bC0gWiwwky1Cf3+
	8NrHJlqwapoKpRMFzyrwm9FCoA==
X-Google-Smtp-Source: ABdhPJxBd7qMDWG5mBQ7lPT5qB1dNn9jPBmRG2iPyZYBOu0HfK4TWkpbbNhRvxFWUj+3ViFBu7RsTg==
X-Received: by 2002:a05:6402:cba:: with SMTP id cn26mr4786117edb.201.1635415921062;
        Thu, 28 Oct 2021 03:12:01 -0700 (PDT)
Received: from [10.44.1.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bq4sm1121464ejb.43.2021.10.28.03.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 03:12:00 -0700 (PDT)
Message-ID: <90ac2577-1542-b286-732c-4c179ebbd998@tessares.net>
Date: Thu, 28 Oct 2021 12:12:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v4 0/2] Splitting commits for IP_TOS support in
 setsockopt()
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Poorva Sonparote <psonparo@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1635367735.git.psonparo@redhat.com>
 <119548f6-ee97-48c3-ccf9-3ce623371c58@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <119548f6-ee97-48c3-ccf9-3ce623371c58@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Poorva, Mat,

On 28/10/2021 02:50, Mat Martineau wrote:
> On Wed, 27 Oct 2021, Poorva Sonparote wrote:
> 
>> - patch 1/2 Add Support for IP_TOS for MPTCP setsockopt()
>> - patch 2/2 Exposing  __ip_sock_set_tos() in ip.h
>>
>> Poorva Sonparote (2):
>>  Exposing __ip_sock_set_tos() in ip.h
>>  Support for IP_TOS for MPTCP setsockopt()

Thank you for the patches and the reviews!

> Thanks! Looks like this is ready for the export branch:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Now in our tree (features for net-next) + added prefixes in your patches
("ipv4:" and "mptcp:"):

- f80cd2ae7b35: Exposing __ip_sock_set_tos() in ip.h
- dcb0d4eb4318: Support for IP_TOS for MPTCP setsockopt()
- 758c711752bb: tg:msg: prefix with ipv4 and add Mat's ACK
- 76fecc38fcfb: tg:msg: prefix with mptcp and add Mat's RvB
- Results: 4af534378cb0..a1638f497c0c

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211028T092928
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

> It's not necessary to use getsockopt to implement a test for this, you
> could also use 'ss --tos' to see the tos value on the mptcp socket and
> the subflows. Would be good to have a selftest for this before upstreaming.

Should we add something in the selftests for each "simple" sockopt? I
mean: it can be quite "heavy" to create E2E connections, wait for them
to be created and be long enough, check for an output with external
tool(s), etc.

For more "complex" sockopts like MPTCP_INFO, it makes sense because it
would imply a lot of modifications on packetdrill side.

Should we discuss about that at our weekly meeting?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
