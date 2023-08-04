Received: from out-73.mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C70A49
	for <mptcp@lists.linux.dev>; Fri,  4 Aug 2023 04:31:48 +0000 (UTC)
Message-ID: <acdc562e-c1e8-c192-6067-ef0cc19d345e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691123506; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG8WinUCnlAHXaOSTGJ8A/AVyvLBZtScitTRi5Uly+o=;
	b=a5VrgZHQbX66Z5qDRFN9Y5ayOt63ZhJIwyeS3yITnqjE+Sug4a71+BrOPQ9N4QNkJjWumc
	vXXtji2OwaYnwiIGwtJFAPBCOn+DOeGMp6eZ3dGCOO0GrZzkAsdaaw2TYQ88fq3IkOpsBI
	5ab1nM5mJFQIGmsG4k8AQO5n8AZgRVw=
Date: Thu, 3 Aug 2023 21:31:37 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v10 4/5] selftests/bpf: Drop unneeded checks for
 mptcp
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691113640.git.geliang.tang@suse.com>
 <5eecd03fc0eaecc19da6a40bb118690971a8a7a7.1691113640.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5eecd03fc0eaecc19da6a40bb118690971a8a7a7.1691113640.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/3/23 6:55 PM, Geliang Tang wrote:
> Load success means prog_fd and map_fd are always valid. So drop these
> unneeded ASSERT_GE checks for them in mptcp run_test().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>
