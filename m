Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E779DE
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 16:17:43 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id r11so91706918edd.5
        for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680279462;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=El1JtG2rfAZqrb6zpxpzTggvRK9LO8pBiqIEGUyTP0o=;
        b=TKJk59UuBLxjD4iV3E6i4P/qOsxbzZOz/eMRJ1ELzBLwtfSROv27E5q5kdBzwk+gMv
         gT9UGFZ6Y36RZ3ymG6NK8SMo+oX7lQv59Sq7t626fzZ8kR9WKvtfg1coextaz2/lQSk3
         WPCb7kMaLqexUu51mgxGJSRrgsbM5o7rH+f56hm4MKBgkrTT6i6n1fGiQb9XQxx4aiZm
         3jv/lLu4rdVYwJAlxEQGsQwKbduEMAAF0F7CX4/ZebtQsAy9etJBOfXD4MOSsYHeDZbJ
         ghpHLJ4OEoVBLRdTu/t7Yommjl6D4OOmY0Yo+QzbYw9KPVHimWvFLyWzHPNK0g9rg/ex
         tS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680279462;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=El1JtG2rfAZqrb6zpxpzTggvRK9LO8pBiqIEGUyTP0o=;
        b=fv1tRj9ehnJtPyeGSf6mFPSi9ptb2taX+BzhWDLckBTi19V2zQ+pAUSpS/t/tNxDow
         UbYGE3kzCpB09rBJj7xEaLV/RUsFA4c0+3tlawTbhycx3Fqa47Uk7MHmEJyB2f2xTsRx
         nlgSoNi/TGoqrxTRRjKhhLqQlwn8yww6OJ3VUdiYC4UGUcHncycdoS5vznpFWO4Vwk+y
         oJnaqmLjBLiMtFZM1K189B9LBYs3IiLJ4eP6aA0LO+0swKLHb4sqhzVV6EojwqX4JEGB
         xuKXlt7Hk6VykM2YGd4teVsFaOG+U1hGJQvPp0GRFYKl8M+lVNpu1zCdvu0HlKRHiBL1
         04+w==
X-Gm-Message-State: AAQBX9eQ50XD8ogaJ+fKWrfWN2KBnrBAvPea1vLr357+Lwinbj/SjafO
	JRg7UyG1QpNRO6MqSVHDS4KeVA==
X-Google-Smtp-Source: AKy350a19pCMj8Ccw0Dqv4D7UbVH4xEJ1XgS70Sh3ioGvos7cvvqcYzuSfJjEM6wRycpryplS1sYzw==
X-Received: by 2002:a17:906:524a:b0:931:7709:4c80 with SMTP id y10-20020a170906524a00b0093177094c80mr26512064ejm.71.1680279462120;
        Fri, 31 Mar 2023 09:17:42 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id me6-20020a170906aec600b008d173604d72sm1138342ejb.174.2023.03.31.09.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 09:17:41 -0700 (PDT)
Message-ID: <91d12fa8-d7e0-4ccb-1ff5-9336f6a3506e@tessares.net>
Date: Fri, 31 Mar 2023 18:17:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH mptcp-next] mptcp: make userspace_pm_append_new_local_addr
 static
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <0f4d10f41b5a51353cc4738d6b5d63b9aed8b1f7.1680252220.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0f4d10f41b5a51353cc4738d6b5d63b9aed8b1f7.1680252220.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/03/2023 10:44, Geliang Tang wrote:
> mptcp_userspace_pm_append_new_local_addr is only used in pm_userspace.c,
> so make it static.

Thank you for this cleanup!

I just applied it after having added a reference to commit 4638de5aefe5
("mptcp: handle local addrs announced by userspace PMs") just in case
this commit needs to be backported for some reasons: it could have been
static from the beginning.

Other than that, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (feat. for net-next):

New patches for t/upstream:
- 70fcd42eef63: mptcp: make userspace_pm_append_new_local_addr static
- Results: f0a5c9622efc..e2a442363ad9 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230331T161527

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
