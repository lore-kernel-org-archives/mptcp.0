Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFF2FAF
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 07:04:43 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id b15so2876132ejg.10
        for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dc2CtB453bbUM7DK8SdE3kwFHhkcjPJrEC6RBtH3hAk=;
        b=fCZ+M8YjTxyG1H/SmwVulaKIqgnEyK8qxGRxcDpOmV4ejdNY/kfhOp/LN/xUXTFhU6
         7O5+3og/cw1CBB378g1E4ZGau5YX8efHXo3zuJxO/pX1EYHzghBRzn7N3Ub1QXZz5spv
         412+z3TThmoHujgRLKqJraZn3eXkdDMHeOxJTCIQUuuG+xJFqFwUcd2TUdC/jyH+eh7p
         YxF5MF6Z29QQPpwlc/uyqDGlRDfELrgk+nJzdTkUcS0jtCiQZC/V47lL2QID0tgNYmVu
         CgvsLwurdYS/tW52PZhkfQrtPHzKqmH34Px+pvbfomXRl0j0d6rT4SerlafT1DyCMSJF
         qWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dc2CtB453bbUM7DK8SdE3kwFHhkcjPJrEC6RBtH3hAk=;
        b=h7lxtIF4TP4R+RzDqwBDwQNmtNTKm+jaBmdZl+LQk0NtQYBZ5+3pCpDZBjAABvqar4
         cUAuWlvelJHuFGPC04B3mb38x8BHG8RTQ16rehXMSNwGjFLLxiQkOwOyHdi7EB1xk403
         2wEqFjC6YLpSI6cA+aqnjvGjS+0btI2ZCwKe/tBEz+YUggijRtCCkg6oMBlwgjcSyEwz
         /BYbgKxiNdOD36ohX9JKMf7iN3rA+JR08DVz0keMiXgcM2mzvq7ppXcDtf6aRhBePXm/
         p86O8U0Viok9uhh7WAcdhjy0ay+1ZPVEmXNmCxKNhKltzGS1Qx9Z4C+lYlEqk0bnDggB
         LfXg==
X-Gm-Message-State: AOAM532yuGbfRCN098Q1KciHA0dH+D2SMlBU8hletQO4dYe2wMd56JFB
	wh6+q3nNcgt3XzymMptPcIYpMXZqjCDhSGWT3G8=
X-Google-Smtp-Source: ABdhPJwqCdWpaFQORK8gImNcGpzuwlsLvXGx8m35/7f6HrDeoHsnZKZAjO6xwiM1Km6fpMGPLDqBcA==
X-Received: by 2002:a17:906:720e:: with SMTP id m14mr8212269ejk.500.1629270281833;
        Wed, 18 Aug 2021 00:04:41 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id f8sm2151179edy.57.2021.08.18.00.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:04:41 -0700 (PDT)
Subject: Re: [PATCH mptcp-net v2] mptcp: fix memory leak on address flush
To: Geliang Tang <geliangtang@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <b73d65b78787ba0ecc36ec2d5d6fc2a68415d938.1628863533.git.pabeni@redhat.com>
 <96a46335-40c7-ddbf-be45-aab07b8d3d4b@tessares.net>
 <CA+WQbwvk6uY5zajSYgb59_FdDSB4oQ+6Lz3Er3JAEdm1OvFrcQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <153b0dd4-3d04-e50c-c47f-24c8032a249f@tessares.net>
Date: Wed, 18 Aug 2021 09:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwvk6uY5zajSYgb59_FdDSB4oQ+6Lz3Er3JAEdm1OvFrcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 18/08/2021 05:16, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年8月17日周二 上午1:31写道：
>>
>> Hi Paolo, Mat,
>>
>> On 13/08/2021 16:05, Paolo Abeni wrote:
>>> The endpoint cleanup path is prone to a memory leak, as reported
>>> by syzkaller:
>>
>> Thank you for this patch and the review!
>>
>> Now in our tree (net) with Mat's tag:
>>
>> - bbffcd9faae3: mptcp: fix memory leak on address flush
>> - Results: a5b32fb5c3ca..55f3937bfef4
>>
>> Builds and tests are now in progress:
> 
> Hi Matt,
> 
> I think we can close issue #223 now.

Good point, I didn't notice the 'Closes' tag was missing.
I just closed this ticket.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
