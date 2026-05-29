Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE91A682A;
	Fri, 29 May 2026 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022506; cv=none; b=JQxashGIEO4uvHd08dMGs8Tn8bPPcGSfARdcpYzdijiCO0uPoMozxwPc0CbTB02Mdr5a/CFiRJcaZAUyrS1IK9lutkVFTyz1sW4SgTj2wFF7NF7sWW9d2eIE9r6UI+nNqVn4OhzhH8UzrPuCePhz5ZqPOxYFgXSIR1eS2GVxNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022506; c=relaxed/simple;
	bh=61gh181kUkFDYXEmfnr+rE64RtfoLHvIVhZP+9044Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW+oP6ZhuG4x42fi8UybcQdZu8G9sS+bxZL3hWdJ8Njp2a0IoAln9bnCj+/3rljFKnosB1aGnTPoSeeEpk0gZlx2k1eMdW4ZfxZquuWuYguzQSQgGPfosn5VOuI0LU3TO3ASVHLEJikv/FzRqjThS7vME7gytFIQN14FKzkJORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmgUJ425; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmgUJ425"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD81F000E9;
	Fri, 29 May 2026 02:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780022505;
	bh=JJfUlI77/Hd4asObDFQxvnp6N9PhW7Eg8r9uUrRN9BQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fmgUJ425AUoz9GnkioWLIIx+Rjl5t1zPmhKfMkxFV9TcnB/MnFUMrBFVDTA+LPwOx
	 /4/j2nyuD34yyGPKQjpn1iTa6hiswpq3KaOxTr390Y/qOH/kQ3cVbvp2nO8wj5CS7M
	 nTBAPBmdrkvsIjavHOGzXHoFSb5d95+lhzbGw7Od31uOMEWuxkC6Zg+KMC8cmwPjGc
	 1BVbDKeIoa7H6UVlxrwayVqIYqMhwlIj9ShwFaPGyoEJ9tCyvz4RKXHOWnrz1drU+1
	 DolxHde2jJONhyNh5lZI/kUHCQbZ4YYXLAkXHylwnK5xpBKbMv1fDajW/saMb6aHjH
	 W9xy4gLzxjnNg==
Message-ID: <ba9aa82d-efd6-48c8-8e90-8820a21c5402@kernel.org>
Date: Fri, 29 May 2026 12:41:39 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in
 mptcp_established_options
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, kuniyu@google.com
Cc: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
References: <69f8e352.170a0220.bb392.0005.GAE@google.com>
 <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
 <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 08/05/2026 19:27, Paolo Abeni wrote:
> On 5/7/26 9:44 AM, Matthieu Baerts wrote:
>> Hi Paolo, Kuniyuki,
>>
>> On 04/05/2026 20:20, syzbot wrote:
>>> Hello,
>>>
>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>> KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt
>>
>> It looks like the issue is different now:

(...)

>> Plus I'm not exactly sure to understand the issue here: mp_opt is
>> defined and used only in mptcp_incoming_options(), and I don't see
>> anything using it after the end of this function. Or did I miss something?
> 
> I also had hard time understanding the backtrace, I think some frames
> are omitted/missing (it happens sometime, IDK why), specifically the one
> related to mptcp_options_received() - which would be useful to
> understand the issue.

Because the other issue spot by syzbot seems to unrelated, do you plan
to send your patch upstream? Or do you prefer if someone else does it?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

