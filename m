Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.153.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E372
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636640916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q28WlcC2OkBBqVYgOpPKWp81VCdCGj9lx4pq0K79t5c=;
	b=axh/drWNMh2IjnvsssY9064LMzCeVt13+bApQC+ZS+4P04HXIC4shhqOk1K0OIoEFYJzPr
	+Z/6+oAQAwR91l12JP+FN4HUkHO4ZtPQ9zf5EhhBkXv+9nEEcipbv2bV7teRqxiyspMy+r
	JiBFQuzuhmgejQzjBrM+G0wfLVDa0+U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-5JpdRjKfMGeL-ys3uUwN9w-1; Thu, 11 Nov 2021 09:28:35 -0500
X-MC-Unique: 5JpdRjKfMGeL-ys3uUwN9w-1
Received: by mail-wr1-f70.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so1025328wrw.9
        for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 06:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=q28WlcC2OkBBqVYgOpPKWp81VCdCGj9lx4pq0K79t5c=;
        b=46Jr2/7tRKT3PIDtXaVjxdaVanCxl+T09/RJSCba0Iy/OodDKecDefPJGzMBD7yzgB
         IhVz4b3o5tfhfA6VL/2bHkafeEGs66P2Uu67Z4k5AuzaGvRYdu6ZZIX7+ZCDdJnqBYpK
         g3rNieeJ9JHV2A/cx3Cz09e8PHX8evY3baTXJwI7do5StQuMQnX0sYpEYgAcEX3DuPB7
         ouRDMNvjNKgP5M/nnFBPQonPCDl3d9HD443j1PL3Mv2lx/q0zkZp+/G5Ygb9mF50DYqD
         kJdxMqSHXRaUyIqCKDBGlrW5MqsbZzivml0TQMOFrb+GUg0L/ITTNrzWoxUlF5LRnlKb
         IUPQ==
X-Gm-Message-State: AOAM531GjFaKOsEXHba9u/TPkG+Xek9rdmJGrVsnVwV7W5iGp9ewHf6S
	d/pvUW/itbWx/05Ban07KdM53pb1O8Ul69nZHZlrYc9BBk/GTtDju5NUPTqxt7L6Kn+yAHnsQSH
	SNKVZPq++Hx358lc=
X-Received: by 2002:a05:6000:1813:: with SMTP id m19mr9221128wrh.51.1636640913735;
        Thu, 11 Nov 2021 06:28:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1f7gMDwvmsluhdsi+BMDj6eMNS0Jigp0lMTsqgczWsL+JCax3hc+TPHtRD6B5jyRN+x7Xew==
X-Received: by 2002:a05:6000:1813:: with SMTP id m19mr9221105wrh.51.1636640913528;
        Thu, 11 Nov 2021 06:28:33 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-97.dyn.eolo.it. [146.241.224.97])
        by smtp.gmail.com with ESMTPSA id c17sm3284659wmk.23.2021.11.11.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:28:33 -0800 (PST)
Message-ID: <09a37df1b6b200b795da5e3fea81cf1d010b7193.camel@redhat.com>
Subject: Re: [PATCH net-next 7/7] mptcp: add disconnect selftests
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 11 Nov 2021 15:28:32 +0100
In-Reply-To: <6f3a2c6-3bf9-df0-8fe-942c22824c79@linux.intel.com>
References: <cover.1636545174.git.pabeni@redhat.com>
	 <992a16d382afe5932897687bb6b5f383af6e887e.1636545174.git.pabeni@redhat.com>
	 <6f3a2c6-3bf9-df0-8fe-942c22824c79@linux.intel.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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
Content-Transfer-Encoding: 8bit

On Wed, 2021-11-10 at 17:31 -0800, Mat Martineau wrote:
> For the series, I only have one small request: please update usage() in 
> mptcp_connect.sh with the new options. 

?!? there aren't new option in mptcp_connect.sh. Do you mean
mptcp_connect.c ?

Thanks!

Paolo

