Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C571
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 16:54:32 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id n2so53975627ejy.7
        for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tnr4MN46bEEMW5wNjm+8YyeT0zKQQMAIjNdo/Wbf/YE=;
        b=OOkN68u0uyDHVGFky13sptlUR+AQtInb45Mg77WCYenXZDaNLvT8Fnkd/cbwucxicL
         e3qnZJf1wjefnDpkhZ4MjWgoO/rpar/88WeqhAacDd1RkIVaHo5JlKNtVw0OFtnLz0hQ
         IqxfWU4Lfm8gDftn4wnUv/gVlB5als/wQobwdHpDVAGBidnMguT8BbrNrPqdY7PWM+5D
         ACUhkGEAMtkIEOUQ1KQkNrVH7/bSbXoZKLyK8CMbKfddemm4yvepSlh16ux7Gc00KN89
         lonsqBHFScRmncMltnkUqV44e3RTf3Fjk4B6sjo3NlfsbzKD7EYlBln9A9fVV5cLwBCG
         4uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tnr4MN46bEEMW5wNjm+8YyeT0zKQQMAIjNdo/Wbf/YE=;
        b=OMVkQz2FpnEY/+Sc1TIdPXVfAM2ccowgfOcK57CXlqel35eN7zWwNZEsr6yG62TZ9U
         HLFRePN8tjmk7kPXvKbIU4Av0FY7zaiwcdqKKC35CwPYHYxU3AyGTs/vpeNDpSKqut1G
         l2eRSJBCWoF4vXErQMHRoWKmBapQ81Ivcsv429YPmpiC84wTwSiF0L1BduORJZbYhqjY
         QtOEOa1K5bof4iRaSGqKIVoduTkK0YqCvEHv95yUPO7nohe770nl3PqoouGh7CetBIjY
         howM5rGZF0RP7va7EUuaQ7CxmszZdqTQANMJzlyjZBFIP8ti3qp/nZcKJvuBAOku4Jmk
         VX0w==
X-Gm-Message-State: AOAM530uzYjAOw3loqpb3/DX05LnE2ppShpQqmEAtxrwTmSRf6RG9f6d
	WEZQWjoXNZv0AbqlsNoxpRHG6v/EdsXQVUkW
X-Google-Smtp-Source: ABdhPJyn3wE3eCyZMqIhb2eXs7A0Yhg2oBLh6r5fg9ndPGeUyr/rIepYe9M+96jqHZgKAXYP68n4Dg==
X-Received: by 2002:a17:906:86da:: with SMTP id j26mr17048254ejy.187.1618851271256;
        Mon, 19 Apr 2021 09:54:31 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([185.156.172.168])
        by smtp.gmail.com with ESMTPSA id 1sm10765299ejt.95.2021.04.19.09.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 09:54:30 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] mptcp: add MSG_PEEK support
To: Yonglong Li <liyonglong@chinatelecom.cn>, Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, fw@strlen.de, geliangtang@gmail.com,
 qitiepeng@chinatelecom.cn, mptcp@lists.linux.dev
References: <1618800836-76736-1-git-send-email-liyonglong@chinatelecom.cn>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8f1bbf9c-ebf0-64c4-55be-f8aa04274b2c@tessares.net>
Date: Mon, 19 Apr 2021 18:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1618800836-76736-1-git-send-email-liyonglong@chinatelecom.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Yonglong, Paolo,

On 19/04/2021 04:53, Yonglong Li wrote:
> This patch adds support for MSG_PEEK flag. Packets are not removed
> from the receive_queue if MSG_PEEK set in recv() system call.

Thank you for the patches and the reviews!

Now in our tree:

- e7fc5d2f8302: mptcp: add MSG_PEEK support
- 3a43a9f8d6df: selftests: mptcp: add a test case for MSG_PEEK
- Results: 0bc569d1592d..41136bc7e8d8

Tests + export are in progress!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
