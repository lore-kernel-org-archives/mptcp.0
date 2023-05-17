Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296518B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 14:24:51 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so6076305e9.2
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684333490; x=1686925490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9WapjiQjA15S3vawVAf6++NY6kO7+ltAZ4J1UTPvHv8=;
        b=xPEqn6dJhfpk4pZ2DGWSvBnnyjSG0C39oFWx0gsalvGDp6blDgBSpAfhLVU1+BtHiF
         0vyylo6p3E4UknWWz5NHeTuNtpmMNDVhUuEeM/LTQprTjAyCToRqL8A/L2ioeseoxa3U
         9bLsQWOgGSecF8CH/G9Q8HAWPJ4VDC+33q9ZkQW/XmPGajfWhWLI1sh0jOAtEEmQllS6
         HCdUdxOXpepGEzzYlDOQhSR95YwFC13bOl4/uGImwY66djilpcjtpWhK+ZrJlCXxQg5n
         2M65P91lZt4f9ceMVyBep4C5rcLpDPqsU4XaNEhFco02nk9rMqJ5tSrK1cttfdhGYcEd
         ftiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333490; x=1686925490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WapjiQjA15S3vawVAf6++NY6kO7+ltAZ4J1UTPvHv8=;
        b=RsUWpfehJIDpXb3/U9jZKpOtF1YUmYYlQDegsNzaBKW3DpHPq3UVrXWAw5Ak01gxNF
         rapMa0ByzOmKx/zl5tyWshG4LxfZOzgsN+cV0MYln0ka9mfXxrRrkVXXshjCi75XL2p8
         IwkCV/PbXJyFYyV5S1HxsrY0r/qrT4rkTImU51Gpabq8dLUZfyovvR3sCqfZFwP1Lw5o
         m5Jo5V8jNGlCCqI92zox8tXW0mIdjyrBU9GVOFN7vTPE1hn35+Ec6DdZOQo0SjFp7hhQ
         9NdWMES05scbzOims8W+V5sCxvmzP6F2EzaIksQToL+qPldaSEp7PUfvZnwjPQhx2PCt
         XpZQ==
X-Gm-Message-State: AC+VfDxnQkcgRXXMqTQfljG2lrTwaT2AmJRanv/jf3wfqyHQqyRk80xX
	XjgXmqlomrsiTnLb2/pIr2+aGQ==
X-Google-Smtp-Source: ACHHUZ7wwIhwIdVRlS7ojtQO6lQN5WWKw2IZHI535DwT8coQrOkPsJSXYU2CXVAPWx2+L9jJdN8o1A==
X-Received: by 2002:a7b:c44d:0:b0:3f4:e4cd:f83 with SMTP id l13-20020a7bc44d000000b003f4e4cd0f83mr17080774wmi.5.1684333490069;
        Wed, 17 May 2023 07:24:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d4e45000000b002f28de9f73bsm2889661wrt.55.2023.05.17.07.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:24:49 -0700 (PDT)
Message-ID: <3202fac6-9bbf-b47a-2462-e8ec9b31d779@tessares.net>
Date: Wed, 17 May 2023 16:24:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 0/4] mptcp: add some more diag info
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1683212362.git.pabeni@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1683212362.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/05/2023 18:39, Paolo Abeni wrote:
> This is a follow up to the topic discussed in recent pubblic mtg.
> 
> Introduces unique id for accurate subflow stats tracking and
> aggregate mptcp counters, plus some minimal self-tests.

Thank you for the patches and sorry for the delay! I have some questions
if you don't mind but I think they are not blocking. So the patches look
good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

> The tests themself do not take in account support for running on
> older kernel.

I can take care of that after having applied the series.

> This is on top of "selftests: mptcp: centralize stats dumping" - 
> that is should land not on top of the current export branch head.
> 
> That in turn will cause some non trivial conflicts with:
> 
> "mptcp: use get_retrans wrapper"
> 
> the resolution should like the following (for brevity only reporting
> the lines affected by the conflict resolution)

Thank you for having checked and shared that!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
