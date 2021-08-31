Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83EB72
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630403179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBpzEpex8IUJ4v+RKXhUBpPVjOfa+itu9FLEeK7b78o=;
	b=gLWY+NWxYVg1TzOReiRH35wNXgIsRkbKOBncIYHrDhSDlWA8ZJRvn6nxEca4M7bxYEQimG
	Hr62n2/y5Jvuj0MbOysHaNVALxxRKY+4HTMzMtaoDY7r75xLMFfdLGaziDw6CY1Z+4In6S
	mxw4v+Q1+bIEYQ5ZWft0Fl24z/fZ75k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-pKV7GJSuNaW1qsdoWQUCIg-1; Tue, 31 Aug 2021 05:46:16 -0400
X-MC-Unique: pKV7GJSuNaW1qsdoWQUCIg-1
Received: by mail-wr1-f70.google.com with SMTP id z16-20020adfdf90000000b00159083b5966so363214wrl.23
        for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 02:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LBpzEpex8IUJ4v+RKXhUBpPVjOfa+itu9FLEeK7b78o=;
        b=JjcPHpogL3OY0WF3b/jQHJRa0yR7cQ75DXOdosLkQl8lnw01GPT0wPaq3l7ci4yQlc
         J8sjymJsuJMCVvBwqtNu2xkYo2Z4Ce4W1mDYmHzOw4m3mad+IrkfuUID7FM4HNm+mqwt
         26MJjCBqBjYfJcsS6IgscrKSwN6YZBCmqXIEQRhrqYvHTAizebS81apq7U/J1cE3qRvW
         rJnVglkrWBIeD/q1px7rqmr9wSnCfNZ6SKjhjOKgl0gPmb7Lhwa2By0+c+crPY9rvn5g
         k0zltJV4DLVjnfcfXu3/iXjV7CsOlDYL+I1xtdlmpb1uU42IPTlU4EmUQIslYfdWguC8
         iSiw==
X-Gm-Message-State: AOAM532YIj9qyYfyXzGJXCc4DDMxdr+J9wW+XZt+pzfhNHAEzHe7PJ6f
	n6MATVLF5fgYyUouROjlJmyTsuFYk4Mq6Uz8yhZeHtXFJGUlRz0+rTrXt9Qm1VC6vlg/dKj3gM3
	JrKvrvZ3l4b/jkNo=
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr2971859wrr.298.1630403175767;
        Tue, 31 Aug 2021 02:46:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFRH7VBbE8Ftby3zrHfhWdg61hVwuj3+UIq4qskCglCC1dijz3AGmLqv7xX9GxUg7JWFfqew==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr2971845wrr.298.1630403175545;
        Tue, 31 Aug 2021 02:46:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id r12sm18221119wrv.96.2021.08.31.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:46:15 -0700 (PDT)
Message-ID: <499c9366e65bc7257ba48c831bf7c28e33503b84.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: Only send extra TCP acks in eligible
 socket states
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: geliangtang@gmail.com, mptcp@lists.linux.dev
Date: Tue, 31 Aug 2021 11:46:12 +0200
In-Reply-To: <5ea0f310-8798-e436-24ae-2476b16b1813@tessares.net>
References: <20210826004601.196834-1-mathew.j.martineau@linux.intel.com>
	 <5ea0f310-8798-e436-24ae-2476b16b1813@tessares.net>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-08-26 at 20:24 +0200, Matthieu Baerts wrote:
> Hi Mat, Paolo,
> 
> On 26/08/2021 02:46, Mat Martineau wrote:
> > Recent changes exposed a bug where specifically-timed requests to the
> > path manager netlink API could trigger a divide-by-zero in
> > __tcp_select_window(), as syzkaller does:
> 
> (...)
> 
> Thank you for the patch, the review and the testing!
> 
> This is now in our tree:
> 
> - ea8a43942429: mptcp: Only send extra TCP acks in eligible socket states
> - Results: 99a16463048d..6d52100ab2ab
> 
> > Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/229
> > Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> 
> Checkpatch is yelling at me because a SoB is not present here.
> 
> @Paolo: sorry to ask this question but for the record, is it OK for you
> if I add it? :)

To be more formal:

Signedo-off-by: Paolo Abeni <pabeni@redhat.com>

