Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A47F6
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655717064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9DBfIMzBuHOZVZqYnmMf4tug9TnD89xgLo/gbh3txo=;
	b=DwCAMmpp+CMbbCNYroge6zBW9AwWIrOi67uNh+08sqa4c7asIdE2l/F6YTOYYAT1gQBSbr
	nF3Skpi1d2KrmNppWGofA6PR0NCMn563gqahVeSkrbV9Oovdo0GG8FW8KN9VVKgXsXhV04
	Yw2/mZjCWjI23jXYoWB3/7YcmnBhtBw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-XEPZx__qPMuTAn5WBbHVvQ-1; Mon, 20 Jun 2022 05:24:22 -0400
X-MC-Unique: XEPZx__qPMuTAn5WBbHVvQ-1
Received: by mail-qk1-f197.google.com with SMTP id bk10-20020a05620a1a0a00b006a6b1d676ebso12545850qkb.0
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 02:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=c9DBfIMzBuHOZVZqYnmMf4tug9TnD89xgLo/gbh3txo=;
        b=m84KblKGL7CaV19iSoh7hzlB0hkRoBukcOfOpVzCR/LprQ47KIYk47CAIAoWHQSJqp
         KpNHGFluoOZqbNKnynQsecEitYq3/d1v7LV5TF/SyyUL48UjEc4NKMzZPAQ+wh84JR4w
         wugNsPfuyslVjov4yGGX3dQwHoJcM5GciTbeXf1NTEpFWioag5RWB/vIU8vomf7A1ydd
         l8sBNhm7zIsYBd7CG9wwKKbLjVMfPM4vSYPbY3gmWZNkVoF3Kbe2d1clrmKPNP5CY9Hv
         IGZF8uLG7O0+iY6BDVM1JJ8yKW5erQ5qhWhdGZM3ReewEC39JDgiLFOBhpaoa0J8NWo2
         NYXw==
X-Gm-Message-State: AJIora98Z/ti0Rgxmk6TZKBUSqaj+Ic3U6Jij5BINZeHWw7c37y0fsWy
	/oT7s0exkDiGTF0e5D8kkAagSnshJZbZj4SdokoxHRtpiCBLvalQ167L7a87BvggseCCQqRcwZB
	oUElWOb2JmcsXe2s=
X-Received: by 2002:a05:622a:20a:b0:304:f641:d715 with SMTP id b10-20020a05622a020a00b00304f641d715mr18617875qtx.436.1655717061907;
        Mon, 20 Jun 2022 02:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vSo697n+uLqCo+8Rk0rRimiu65QNLCKcjhSZf4U5HG3skN8dmm0QYCtlj7zPn6qsN44mDZPw==
X-Received: by 2002:a05:622a:20a:b0:304:f641:d715 with SMTP id b10-20020a05622a020a00b00304f641d715mr18617863qtx.436.1655717061634;
        Mon, 20 Jun 2022 02:24:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006a3325fd985sm11218692qkj.13.2022.06.20.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:24:20 -0700 (PDT)
Message-ID: <fc54768bf696bc52c85c54a98ac75494ca7b0f40.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3 2/6] mptcp: introduce MAPPING_BAD_CSUM
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 20 Jun 2022 11:24:16 +0200
In-Reply-To: <4a8c5ba-f234-9623-a36-ba3235744bf@linux.intel.com>
References: <cover.1655460262.git.pabeni@redhat.com>
	 <dd078642fb80c4bb1f3184393cee1907026df46c.1655460262.git.pabeni@redhat.com>
	 <4a8c5ba-f234-9623-a36-ba3235744bf@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Fri, 2022-06-17 at 16:13 -0700, Mat Martineau wrote:
> On Fri, 17 Jun 2022, Paolo Abeni wrote:
> 
> > This allow moving a couple of conditional out of the fast path,
> > making the code more easy to follow and will simplify the next
> > patch.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> I've had a few rounds of feedback from Jakub about the Fixes: tag in the 
> last few months - whether missing for -net or questionable inclusion in 
> net-next... So I'd like to get this right :)
> 
> Given that this is tied to the following patch ("mptcp: invoke MP_FAIL 
> response when needed"), and that patch "Fixes:" a patch that's only in the 
> 5.19rc series, I don't think a missing tag here is harmful. But I'm not 
> sure what Jakub will want.
> 
> One option is to duplicate the "Fixes: d9fb797046c5" line from "mptcp: 
> invoke MP_FAIL response when needed".
> 
> What do you think Paolo?

I thought about the tagging, and I think this should be fine as is.

Thanks,

Paolo

