Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297022C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:59:20 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id y3so5775941ejf.2
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=oPCL84rhc1Ah+6I/nwO3nf/bNFU+XsRLjBkAz7Dqz/Y=;
        b=V0zj2rfoTyDbGfsp0+Rm6r+RqFoiGylEiw/MP4mAzgFUTIfOA55G1W56vZRV943Ap4
         5fT5YNWNmQijESLp5dn2b7xdlC/QB++uzsKf1CRMZco8DqyK//5Kj43vgvYA4JHi8xAr
         Ue5x5o3I7dZlX9fCFn08SQGEmmNeF5GNiLL0zEAY+YbJu3KMS1A16A3QVZAqkNwwDUIr
         O45ILgPoU+KztDWGEyCs78Nu6CrSvegj7QCc7Hlks3DbYHWIewnXyOWpiWuFwsJMKHHD
         PK4WnHD+g9BmKYVGOSiFurL0ixmtOHDvbAE/7IK8zl8/hZe/FlvVTPHyOye4iaO0Ro/e
         MdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oPCL84rhc1Ah+6I/nwO3nf/bNFU+XsRLjBkAz7Dqz/Y=;
        b=l2EwKlS+yM4FrNteJxJat4PNliUNppWk6CltYyyKjhFqTuv6rybPObU7CSlCLcUkgY
         s8Xd65NiBKgt1CtINP6+B0rIHfG9YxuvciBlB3jQqWYV2Qni0hk+trJTskZfcSyovE3g
         VUlaREA4+u/qcM42hJQl4uH8Y2wpZLesGtXd63YQURNZCvafJZwtCoNGhYm3ci/mak5i
         Ql7FrW+06ROw1fN8k/GWpOrc3iHkN1uDI3yCVOjkjE6pdZPCAPywt/7h8qTuMa3NMiX+
         BUU6KNETdZAFOKoQkThZdNJHXkyULMmPyxWMfJiIU+IQ39+ihW8iRoRVbKYdw8Ldstys
         mFWg==
X-Gm-Message-State: AOAM531uvrWzNCBz67NsnTAu7KO3BKAXrtd0DqSt1ttv7ike9MWctvpr
	gJc+ULhGbx0nKtr/r9zy1hJchL7qHtZi5zFh
X-Google-Smtp-Source: ABdhPJzlGrbO+BqDcT6S7nLWF37HiCD6vMLCNcbS1B0aYLTKfNsugWzGhCvorfl/pg5u2luSjHchBQ==
X-Received: by 2002:a17:907:3faa:: with SMTP id hr42mr1220969ejc.596.1644400758381;
        Wed, 09 Feb 2022 01:59:18 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:268e:dc63:f3ef:de99? ([2a02:578:8593:1200:268e:dc63:f3ef:de99])
        by smtp.gmail.com with ESMTPSA id n2sm5436207ejl.86.2022.02.09.01.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:59:18 -0800 (PST)
Message-ID: <617b4fa8-320b-2e88-ee68-0a25e842ee21@tessares.net>
Date: Wed, 9 Feb 2022 10:59:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net v3 0/4] mptcp: fix races in add_addr handling
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1644399915.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1644399915.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/02/2022 10:47, Paolo Abeni wrote:
> the patches 1 && 2 fix actual races, even if the race addressed by
> 2/4 is not exposed by the self-tests, afaics.
> 
> patch 3 introduces some mibs to detect critical scenarios we can't
> fix without major rework
> 
> patch 4 updates the self-test to be graceful in above cases.

Thank you for the new version!

I suggest to apply it now to have more feedback from the CIs. We can
always end Squash-to patches later if needed.


> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/254
> 
> Note: I did not attach the above tag to a specific patch, as all
> of them will be needed to fix the issue

Do not hesitate to put it on the last one so the ticket will be
automatically closed and tracked when applying the patches on the
different trees :)
We can also put it on all of them or use 'Link' on the first ones and
'Closes' on the last one.

Anyway, I can also close it manually if I don't forget ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
