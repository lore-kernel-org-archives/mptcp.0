Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A47A52
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 05:34:39 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id c12so3298292edv.10
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 22:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/UpEKnsFX8fegxKUh181Zap+fZTIe+CZ+opqdsJE2oE=;
        b=5O6RLMXzC3Y+PDSSn8UnBWLF7c+WzADAh4Fl7Ed4EMMuHHnLLoezb3fEtns3YHzsoi
         UoC++ERxGxmlHhNck37E4Z21BMKhofODqP2aseZYkjiYEAbgCkqNRvaoINPSvs2VUuHD
         f2GUhg4XE/3b/K34S2pnElRfbS/PDj8UIBGrSADhdOvG0+mPxc6OwR/ntPVQoJcrj9fo
         oiyXUKoYi2AunXN66lAjAl2vOseWoZPgLIqOyisNl5aqJECg/TMfwjlHN8FK4PRqD6Gh
         XVMrldKHBsHtb4Tz/9o1/Nfa8BWnf6Wb7sKV6z3tYnvlbEGFNnSgcDUmON9lWBOGsWyw
         JCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/UpEKnsFX8fegxKUh181Zap+fZTIe+CZ+opqdsJE2oE=;
        b=rSfF/Kv7Oq2bkcfPtFliTXgcedDIDqf/GTnxIjY+unejzDKa6RAJdZk0HeMF9dom2O
         igvECp+7bkCDpfPYRwJK+PFGg6o6/42yARHrf0A3KbvC+E+dxtHZWUr2A7PuW+ZouSeO
         F076C1MyuB/6mthfPTgLaT+ThmtAZDKPw1fJE+x/moohlwGd5SEpALC/kg7QgF+Ybnod
         nypYOUIF7EsEuNmmZ5JiApwoTBBwMVBkmwhoKa7eXyKpW2BHHvTUnfI4SodJ/DWfzZ7V
         +3c/F+IY/yo5M1o0v8hIwcWUPzJTIMeNgSxJ84ojc+QdeS/aj0CNSKe5RMSwyvYe41xr
         GTqQ==
X-Gm-Message-State: AOAM533RLRYjRptIygO38qlE2grZmK+heSakT/w17prjHFBJOtD/36se
	UmrYOSx0OP17btARa5ZQy/2WWlYJ8PuZ/VZI
X-Google-Smtp-Source: ABdhPJxKGxi1km4dqEH3j0QdbToo0AJsPspe1Kol+YYFfYRugADiTRHj/vQZdAr1g0xxJW3BJ1LxXw==
X-Received: by 2002:a05:6402:3508:b0:427:b100:b825 with SMTP id b8-20020a056402350800b00427b100b825mr7098506edd.268.1651901677634;
        Fri, 06 May 2022 22:34:37 -0700 (PDT)
Received: from [127.0.0.1] ([213.211.147.230])
        by smtp.gmail.com with ESMTPSA id eb7-20020a170907280700b006f3ef214e4esm2623645ejc.180.2022.05.06.22.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 22:34:37 -0700 (PDT)
Date: Sat, 7 May 2022 05:34:36 +0000 (UTC)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Message-ID: <156f008c-477d-4f1c-82c0-0c18a7f21971@tessares.net>
In-Reply-To: <2cef2c7d-d25e-179f-2550-23cc935ad7ec@linux.intel.com>
References: <cover.1651724418.git.geliang.tang@suse.com> <2cef2c7d-d25e-179f-2550-23cc935ad7ec@linux.intel.com>
Subject: Re: [PATCH mptcp-next v12 0/3] BPF round-robin scheduler
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <156f008c-477d-4f1c-82c0-0c18a7f21971@tessares.net>

Hi Mat, Geliang,

7 May 2022 02:06:25 Mat Martineau <mathew.j.martineau@linux.intel.com>:

> On Thu, 5 May 2022, Geliang Tang wrote:
>
>> v12:
>> - init ssk from data->contexts[0], instead of msk->first.
>> - cycle through all the subflows, instead of the first two.
>>
>
> v12 looks ok for the export branch, but Andrii asked for us to use bpf_tcp_helpers.h instead of adding a new header file. Geliang, I think it would be easier to do a v13 with the header changes rather than apply v12 and squash header changes.

I think Andrii is not opposed to have a dedicated MPTCP helper file because from what I understood, he only asked why we created a new file, no?

For me it makes sense to have this dedicated file. The main reason is related to the maintenance: to have us being cc'd for all patches modifying this file. Would it not be easier with a dedicated file?

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
